import torch
import torch.nn as nn
import torch.nn.functional as F
from torch.distributions.categorical import Categorical
import torch_ac


device = torch.device('cuda' if torch.cuda.is_available() else 'cpu')
print('Using device:', device)
print()
SCALE = 2 * 20 
# Function from https://github.com/ikostrikov/pytorch-a2c-ppo-acktr/blob/master/model.py

def init_params(m):
    classname = m.__class__.__name__
    if classname.find("Linear") != -1:
        m.weight.data.normal_(0, 1)
        m.weight.data *= 1 / torch.sqrt(m.weight.data.pow(2).sum(1, keepdim=True))
        if m.bias is not None:
            m.bias.data.fill_(0)



class DRU:
    def __init__(self, sigma=2, hard=False):
        self.sigma = sigma # standard deviation of Gaussian noise applied by DRU 
        self.hard = hard # true if use hard discretization, soft approximation otherwise 

    def regularize(self, message): 
        m_reg = message + torch.randn(message.size()).to(device) * self.sigma # add noise to message 
        m_reg = torch.sigmoid(m_reg).to(device) 
        return m_reg

    def discretize(self, message):
        if self.hard: 
            return (message.gt(0.5).float() - 0.5).sign().float() 
        else: 
            scale = 2 * 20 
            return torch.sigmoid((message.gt(0.5).float() - 0.5) * scale).to(device) 

    def forward(self, message, mode): # mode = D for discretize / R for regularize 
        if mode=="R": 

            return self.regularize(message) # Dial used regularization during training 
        elif mode=="D": 
            return self.discretize(message) # Dial used discretization message during execution 

class VoI(nn.Module, torch_ac.RecurrentACModel):
    def __init__(self, obs_space, action_space, use_memory=False, use_text=False, use_hammer=False, learn_voi=False): 
        super().__init__()

        # Decide which components are enabled
        self.use_text = use_text
        self.use_memory = use_memory
        self.use_hammer = use_hammer 
        self.learn_voi = learn_voi 
        if self.learn_voi: 
            self.use_hammer = True 

        # Define image embedding
        self.image_conv = nn.Sequential(
            nn.Conv2d(3, 16, (2, 2)),
            nn.ReLU(),
            nn.MaxPool2d((2, 2)),
            nn.Conv2d(16, 32, (2, 2)),
            nn.ReLU(),
            nn.Conv2d(32, 64, (2, 2)),
            nn.ReLU()
        )
        n = obs_space["image"][0]
        m = obs_space["image"][1]
        self.image_embedding_size = ((n-1)//2-2)*((m-1)//2-2)*64

        # Define memory
        if self.use_memory:
            self.memory_rnn = nn.LSTMCell(self.image_embedding_size, self.semi_memory_size)

        # Define text embedding
        if self.use_text:
            self.word_embedding_size = 32
            self.word_embedding = nn.Embedding(obs_space["text"], self.word_embedding_size)
            self.text_embedding_size = 128
            self.text_rnn = nn.GRU(self.word_embedding_size, self.text_embedding_size, batch_first=True)
        
        # Define hammer's image embedding
        if self.use_hammer:
            self.hammer_image_conv = nn.Sequential(
                nn.Conv2d(3, 16, (2, 2)),
                nn.ReLU(),
                nn.MaxPool2d((2, 2)),
                nn.Conv2d(16, 32, (2, 2)),
                nn.ReLU(),
                nn.Conv2d(32, 64, (2, 2)),
                nn.ReLU()
            )
            hammer_n = obs_space["hammer_image"][0]
            hammer_m = obs_space["hammer_image"][1]
            self.hammer_image_embedding_size = ((hammer_n-1)//2-2)*((hammer_m-1)//2-2)*64 
        
            if self.learn_voi: 
                # Define hammer's voi module 
                print(self.hammer_image_embedding_size) 
                self.voi = nn.Sequential(
                    nn.Linear(self.hammer_image_embedding_size, 32),
                    nn.ReLU(),
                    nn.Linear(32, 1), 
                    nn.Softplus(beta=10)
                    # nn.Sigmoid()
                ) 


        if self.learn_voi: 
            # Define actor's inquiry model
            self.inquire = nn.Sequential(
                nn.Linear(self.image_embedding_size+1, 32), # adding 1; for cost from information agent 
                nn.ReLU(),
                nn.Linear(32, 1), 
            ) 
        
        self.dru = DRU() 

        # Resize image embedding
        self.embedding_size = self.semi_memory_size
        if self.use_text:
            self.embedding_size += self.text_embedding_size 
        if self.use_hammer: 
            self.embedding_size += self.hammer_image_embedding_size 
        # if self.learn_voi: 
        #     self.embedding_size += 1 # cost 
        
        # Define actor's model
        self.actor = nn.Sequential(
            nn.Linear(self.embedding_size, 64),
            nn.Tanh(),
            nn.Linear(64, action_space.n)
        )

        # Define critic's model
        self.critic = nn.Sequential(
            nn.Linear(self.embedding_size, 64),
            nn.Tanh(),
            nn.Linear(64, 1)
        )

        # Initialize parameters correctly
        self.apply(init_params)

    @property
    def memory_size(self):
        return 2*self.semi_memory_size

    @property
    def semi_memory_size(self):
        return self.image_embedding_size

    def forward(self, obs, memory):
        x = obs.image.transpose(1, 3).transpose(2, 3)
        x = self.image_conv(x)
        x = x.reshape(x.shape[0], -1)

        if self.use_memory:
            hidden = (memory[:, :self.semi_memory_size], memory[:, self.semi_memory_size:])
            hidden = self.memory_rnn(x, hidden)
            embedding = hidden[0]
            memory = torch.cat(hidden, dim=1)
        else:
            embedding = x

        if self.use_text:
            embed_text = self._get_embed_text(obs.text)
            embedding = torch.cat((embedding, embed_text), dim=1)
        
        if self.use_hammer: 
            hammer_x = obs.hammer_image.transpose(1, 3).transpose(2, 3)
            hammer_x = self.hammer_image_conv(hammer_x)
            hammer_x = hammer_x.reshape(hammer_x.shape[0], -1) 
            if self.learn_voi: 
                cost = self.voi(hammer_x) # cost of message 
                ask = self.inquire(torch.cat((embedding, cost), dim=1)) 
                ask = self.dru.forward(message=ask, mode="R") 
                hammer_x = torch.mul(hammer_x, ask) 
                cost = torch.mul(cost, ask) 

            embedding = torch.cat((embedding, hammer_x), dim=1) 
            
        x = self.actor(embedding)
        dist = Categorical(logits=F.log_softmax(x, dim=1))

        x = self.critic(embedding)
        value = x.squeeze(1) 

        if not self.learn_voi: 
            cost = torch.zeros((value.shape[0], 1)) 
            if self.use_hammer: 
                ask = torch.ones((value.shape[0], 1)) 
            else: 
                ask = torch.zeros((value.shape[0], 1)) 
        return dist, value, cost, self.dru.forward(message=ask, mode="D"), memory 

    def _get_embed_text(self, text):
        _, hidden = self.text_rnn(self.word_embedding(text))
        return hidden[-1]
    