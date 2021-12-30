NUMBERS = 1 2 3 4 5 6 7 8 9 10 
voi: 
	$(foreach var,$(NUMBERS), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-voi-$(var) --seed $(var) --voi;)
hammer: 
	$(foreach var,$(NUMBERS), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-hammer-$(var) --seed $(var) --hammer;)
no: 
	$(foreach var,$(NUMBERS), python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-no-$(var) --seed $(var);)
random: 
	$(foreach var,$(NUMBERS), python3 -m scripts.train_value_random --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-random-$(var) --seed $(var) --voi ;)

# # mac 
# target: 
# 	python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-voi-softplus-gpu --voi 

# test: 
# 	python3 -m scripts.train_value_random --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-voi-random-test2 --voi 