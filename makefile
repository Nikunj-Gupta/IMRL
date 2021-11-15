all: 
	
	# python3 -m scripts.train --algo ppo --env MiniGrid-FourRooms-v0 --model MiniGrid-FourRooms-v0_no --save-interval 10 --frames 80000
	python3 -m scripts.train --algo ppo --env MiniGrid-FourRooms-v0 --model MiniGrid-FourRooms-v0_hammer --save-interval 10 --frames 80000 --hammer

	# python3 -m scripts.train --algo ppo --env MiniGrid-DoorKey-5x5-v0 --model DoorKey_small_no --save-interval 10 --frames 80000
	# python3 -m scripts.train --algo ppo --env MiniGrid-DoorKey-5x5-v0 --model DoorKey_small_hammer_full --save-interval 10 --frames 80000 --hammer

	# python3 -m scripts.train --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model DoorKey_big_no2_5M --save-interval 10 --frames 5000000
	# python3 -m scripts.train --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model DoorKey_big_hammer_5M --save-interval 10 --frames 5000000 --hammer
	# python3 -m scripts.train --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model DoorKey_big_hammer_full_5M --save-interval 10 --frames 5000000 --hammer

visualize: 
	python3 -m scripts.visualize --env MiniGrid-DoorKey-8x8-v0 --model DoorKey_big_hammer_full_5M --hammer 