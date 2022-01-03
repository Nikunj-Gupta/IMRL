# linux
NUMBERS = 44 58 28 75 20 18 33 32 24 95 
voi: 
	$(foreach var,$(NUMBERS), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-voi-$(var) --seed $(var) --voi;)
hammer: 
	$(foreach var,$(NUMBERS), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-hammer-$(var) --seed $(var) --hammer;)
no: 
	$(foreach var,$(NUMBERS), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-no-$(var) --seed $(var);)
random: 
	$(foreach var,$(NUMBERS), python3 -m scripts.train_value_random --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-random-$(var) --seed $(var) ;)
prob: 
	$(foreach var,$(NUMBERS), python3 -m scripts.train_value_random --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-prob0.3-$(var) --seed $(var) --prob 0.3;)
prob2: 
	$(foreach var,$(NUMBERS), python3 -m scripts.train_value_random --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-prob0.7-$(var) --seed $(var) --prob 0.7;)



# # mac 

# connect: 
# 	ssh nikunjgupta@10.18.147.188  
# copy: 

# 	scp -r nikunjgupta@10.18.147.188:/home/nikunjgupta/work/voi/storage ./runs/ 

# tensorboard: 
# 	tensorboard --logdir=runs/storage


# NUMBERS = 4 #6 8 10 
# voi: 
# 	$(foreach var,$(NUMBERS), python3 -m scripts.train_value --algo ppo --env MiniGrid-FourRooms-v0 --model FourRooms-voi-seed$(var) --seed $(var) --voi;)

# plot: 
# 	python3 events.py 