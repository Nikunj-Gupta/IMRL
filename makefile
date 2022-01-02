# linux
NUMBERS = 1 2 3 
NUMBERS2 = 4 5 6  
NUMBERS3 = 7 8 
NUMBERS4 = 9 10 

voi: 
	$(foreach var,$(NUMBERS), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-new-voi-$(var) --seed $(var) --frames 10000000 --voi;)
voi2: 
	$(foreach var,$(NUMBERS2), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-new-voi-$(var) --seed $(var) --frames 10000000 --voi;)
voi3: 
	$(foreach var,$(NUMBERS3), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-new-voi-$(var) --seed $(var) --frames 10000000 --voi;)
voi4: 
	$(foreach var,$(NUMBERS4), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-new-voi-$(var) --seed $(var) --frames 10000000 --voi;)





hammer: 
	$(foreach var,$(NUMBERS), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-hammer-$(var) --seed $(var) --hammer;)
no: 
	$(foreach var,$(NUMBERS), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-no-$(var) --seed $(var);)
random: 
	$(foreach var,$(NUMBERS), python3 -m scripts.train_value_random --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-random-$(var) --seed $(var) --voi ;)

# mac 

connect: 
	ssh nikunjgupta@10.18.147.188  
copy: 

	scp -r nikunjgupta@10.18.147.188:/home/nikunjgupta/work/voi/storage ./runs/ 

tensorboard: 
	tensorboard --logdir=runs/storage

# NUMBERS = 2 4 6 8 10 
# voi: 
# 	$(foreach var,$(NUMBERS), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-voi-beta10-seed$(var) --seed $(var) --frames 3000000 --voi;)

plot: 
	python3 events.py 