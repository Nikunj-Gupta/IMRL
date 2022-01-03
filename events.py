from tensorboard.backend.event_processing.event_accumulator import EventAccumulator 
import matplotlib.pyplot as plt, glob, pprint, numpy as np 

files = glob.glob('./runs/storage/*Doorkey-new*/event*', recursive=True)
# pprint.pprint(files)
res = [] 
for i in files: 
    event_acc = EventAccumulator(i)
    event_acc.Reload()
    # # Show all tags in the log file
    # print(event_acc.Tags())
    w_times, step_nums, vals = zip(*event_acc.Scalars('rreturn_r_mean')) 

    print(np.array(vals).shape)
    res.append(np.array(vals)) 

res = np.mean(np.array(res), axis=0)

print(res.shape) 
plt.plot(res) 
plt.show() 