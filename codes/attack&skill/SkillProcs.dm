turf/proc/get_line(length=3,direction)
	. = list()
	var/turf/t
	while(--length >= 0)
		if(t)t = get_step(t,direction)
		else t = get_step(src,direction)
		. += t
	return . + src
mob
	proc
		Square()
			for(var/turf/T in range(10))
				if(get_dist(T,locate(src.x,src.y,z))==5)
					for(var/obj/A in T)
						if(A.density == 1)
							goto skip
					for(var/turf/C in T)
						if(C.density == 1)
							goto skip
					var/obj/cage/C=new(T)
					for(var/mob/M in C.loc)
						step_towards(M,locate(src.x,src.y+1,z))
					skip
					sleep(1)
		SquareFilled()
			for(var/turf/T in orange(6))
				var/obj/cage/C=new(T)
				spawn(100) del(C)
				sleep(0.01)
obj/cage
	icon = 'icon.dmi'
	color = "blue"

mob/verb/Cage()
	SquareFilled()
mob/verb/Line()
	var/list/l = usr.loc:get_line(8,usr.dir)
	for(var/turf/t in l)
		var/obj/cage/C=new(t)
		C.dir = usr.dir
//		sleep(0.00001)
		spawn(100) del(C)
	var/list/X = usr.loc:get_line(8,NORTHEAST)
	for(var/turf/t in X)
		var/obj/cage/C=new(t)
		C.dir = usr.dir
//		sleep(0.00001)
		var/obj/cage/A=new(t)
		A.x += 1
		A.y += 2
		A.dir = NORTH
//		sleep(0.00001)
		spawn(100) del(A)
		spawn(100) del(C)
	var/list/Q = usr.loc:get_line(8,NORTHWEST)
	for(var/turf/t in Q)
		var/obj/cage/C=new(t)
		C.dir = usr.dir
//		sleep(0.00001)
		spawn(100) del(C)