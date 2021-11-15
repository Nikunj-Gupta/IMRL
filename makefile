all: 
	python3 -m scripts.train --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model DoorKey_big_no_5M --save-interval 10 --frames 5000000
	python3 -m scripts.train --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model DoorKey_big_hammer_5M --save-interval 10 --frames 5000000 --hammer