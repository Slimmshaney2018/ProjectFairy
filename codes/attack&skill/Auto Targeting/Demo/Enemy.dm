mob/Enemy

	icon_state = "Red Circle"

	New()
		while(src)
			sleep(rand(5,30))
			step(src,pick(NORTH,SOUTH,EAST,WEST))
