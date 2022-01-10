from tensorboard.backend.event_processing.event_accumulator import EventAccumulator 
import matplotlib.pyplot as plt, glob, pprint, numpy as np 

exps = ['voi', 'hammer', 'no', 'random'] 

files = [glob.glob('./storage-refer/*'+exp+'*/event*', recursive=True)[0] for exp in exps]
# pprint.pprint(files) 
res = [] 
for i in files: 
    print(i) 
    event_acc = EventAccumulator(i)
    event_acc.Reload()
    # # Show all tags in the log file
    # print(event_acc.Tags()) 
    w_times, step_nums, vals = zip(*event_acc.Scalars('rreturn_r_mean')) 

    # print(np.array(vals).shape)
    plt.plot(np.array(vals)[:500]) 
plt.show() 