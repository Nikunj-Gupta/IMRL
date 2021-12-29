all: 
	# python3 -m scripts.train --algo ppo --env MiniGrid-FourRooms-v0 --model MiniGrid-FourRooms-v0_hammer_100M --save-interval 10 --frames 100000000 --hammer
	# python3 -m scripts.train --algo ppo --env MiniGrid-FourRooms-v0 --model MiniGrid-FourRooms-v0_new_no_100M --save-interval 10 --frames 100000000

voi: 
	num1=1 ; while [ $$num1 -le 10 ] ; do \
            python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-voi-$$num1 --seed $$num1 --voi ; \
        ((num1 = num1 + 1)) ; \
    done
hammer: 
	num2=1 ; while [ $$num2 -le 10 ] ; do \
            python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-hammer-$$num2 --seed $$num2 --hammer ; \
        ((num2 = num2 + 1)) ; \
    done 
no: 
	num3=1 ; while [ $$num3 -le 10 ] ; do \
            python3 -m scripts.train_value --algo ppo --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-no-$$num3 --seed $$num3 ; \
        ((num3 = num3 + 1)) ; \
    done 

visualize: 
	python3 -m scripts.visualize --env MiniGrid-DoorKey-8x8-v0 --model MiniGrid-DoorKey-16x16-v0-no  

evaluate: 
	# python3 -m scripts.evaluate --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-value-relu2 --voi 
	# python3 -m scripts.evaluate --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-hammer --hammer 
	# python3 -m scripts.evaluate --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-value-sigmoid2 --voi 
	# python3 -m scripts.evaluate --env MiniGrid-DoorKey-8x8-v0 --model Doorkey-no 