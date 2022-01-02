NUMBERS = 1 2 3 4 5 6 7 8 9 10 
voi: 
	$(foreach var,$(NUMBERS), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-new-voi-$(var) --seed $(var) --frames 10000000 --voi;)
hammer: 
	$(foreach var,$(NUMBERS), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-hammer-$(var) --seed $(var) --hammer;)
no: 
	$(foreach var,$(NUMBERS), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-no-$(var) --seed $(var);)
random: 
	$(foreach var,$(NUMBERS), python3 -m scripts.train_value_random --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-random-$(var) --seed $(var) --voi ;)

# mac 
target: 
	python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-voi-test8-beta0.01 --voi 

test: 
	python3 -m scripts.train_value_random --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-voi-random-test2 --voi 

connect: 
	ssh nikunjgupta@10.18.147.188  

copy: 
	scp -r nikunjgupta@10.18.147.188:/home/nikunjgupta/work/voi/storage runs/ 

# NUMBERS = 2 4 6 8 10 
# voi: 
# 	$(foreach var,$(NUMBERS), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-voi-beta10-seed$(var) --seed $(var) --frames 3000000 --voi;)
