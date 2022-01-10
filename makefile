# linux
# NUMBERS = 44 58 28 75 20 18 33 32 24 95 
# voi: 
# 	$(foreach var,$(NUMBERS), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-voi-$(var) --seed $(var) --voi;)
# hammer: 
# 	$(foreach var,$(NUMBERS), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-hammer-$(var) --seed $(var) --hammer;)
# no: 
# 	$(foreach var,$(NUMBERS), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-no-$(var) --seed $(var);)
# random: 
# 	$(foreach var,$(NUMBERS), python3 -m scripts.train_value_random --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-random-$(var) --seed $(var) ;)
# prob: 
# 	$(foreach var,$(NUMBERS), python3 -m scripts.train_value_random --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-prob0.3-$(var) --seed $(var) --prob 0.3;)
# prob2: 
# 	$(foreach var,$(NUMBERS), python3 -m scripts.train_value_random --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-prob0.7-$(var) --seed $(var) --prob 0.7;)

# mac 

connect: 
	ssh nikunjgupta@10.18.147.188  
copy: 
	scp -r nikunjgupta@10.18.147.188:/home/nikunjgupta/work/voi/storage ./runs/ 


tensorboard: 
	tensorboard --logdir=runs/storage

DO-voi: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-Dynamic-Obstacles-8x8-v0 --model MiniGrid-Dynamic-Obstacles-8x8-v0-voi --strategy voi 
DO-hammer: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-Dynamic-Obstacles-8x8-v0 --model MiniGrid-Dynamic-Obstacles-8x8-v0-hammer --strategy hammer 
DO-no: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-Dynamic-Obstacles-8x8-v0 --model MiniGrid-Dynamic-Obstacles-8x8-v0-no 
DO-random: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-Dynamic-Obstacles-8x8-v0 --model MiniGrid-Dynamic-Obstacles-8x8-v0-random --strategy random 

LR-voi: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-LockedRoom-v0 --model MiniGrid-LockedRoom-v0-voi --strategy voi 
LR-hammer: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-LockedRoom-v0 --model MiniGrid-LockedRoom-v0-hammer --strategy hammer 
LR-no: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-LockedRoom-v0 --model MiniGrid-LockedRoom-v0-no 
LR-random: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-LockedRoom-v0 --model MiniGrid-LockedRoom-v0-random --strategy random 

PN-voi: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-PutNear-8x8-N3-v0 --model MiniGrid-PutNear-8x8-N3-v0-voi --strategy voi 
PN-hammer: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-PutNear-8x8-N3-v0 --model MiniGrid-PutNear-8x8-N3-v0-hammer --strategy hammer 
PN-no: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-PutNear-8x8-N3-v0 --model MiniGrid-PutNear-8x8-N3-v0-no 
PN-random: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-PutNear-8x8-N3-v0 --model MiniGrid-PutNear-8x8-N3-v0-random --strategy random 

OMl-voi: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-ObstructedMaze-2Dl-v0 --model MiniGrid-ObstructedMaze-2Dl-v0-voi --strategy voi 
OMl-hammer: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-ObstructedMaze-2Dl-v0 --model MiniGrid-ObstructedMaze-2Dl-v0-hammer --strategy hammer 
OMl-no: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-ObstructedMaze-2Dl-v0 --model MiniGrid-ObstructedMaze-2Dl-v0-no 
OMl-random: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-ObstructedMaze-2Dl-v0 --model MiniGrid-ObstructedMaze-2Dl-v0-random --strategy random 

OMlh-voi: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-ObstructedMaze-2Dlh-v0 --model MiniGrid-ObstructedMaze-2Dlh-v0-voi --strategy voi 
OMlh-hammer: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-ObstructedMaze-2Dlh-v0 --model MiniGrid-ObstructedMaze-2Dlh-v0-hammer --strategy hammer 
OMlh-no: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-ObstructedMaze-2Dlh-v0 --model MiniGrid-ObstructedMaze-2Dlh-v0-no 
OMlh-random: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-ObstructedMaze-2Dlh-v0 --model MiniGrid-ObstructedMaze-2Dlh-v0-random --strategy random 

OMlhb-voi: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-ObstructedMaze-2Dlhb-v0 --model MiniGrid-ObstructedMaze-2Dlhb-v0-voi --strategy voi 
OMlhb-hammer: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-ObstructedMaze-2Dlhb-v0 --model MiniGrid-ObstructedMaze-2Dlhb-v0-hammer --strategy hammer 
OMlhb-no: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-ObstructedMaze-2Dlhb-v0 --model MiniGrid-ObstructedMaze-2Dlhb-v0-no 
OMlhb-random: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-ObstructedMaze-2Dlhb-v0 --model MiniGrid-ObstructedMaze-2Dlhb-v0-random --strategy random 

plot: 
	clear 
	python3 events.py 