import gym
import gym_minigrid


def make_env(env_key, seed=None, hammer=False):
    env = gym.make(env_key)
    if hammer: 
        env = gym_minigrid.wrappers.HammerObsWrapper(env) # Get hammer observations 
    env.seed(seed)
    return env
