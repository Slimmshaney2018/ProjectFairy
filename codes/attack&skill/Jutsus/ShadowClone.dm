mob
	ShadowClone
		density = 1
		attackablenpc = 1
		var/tmp/ownerkey=""
		var/tmp/alreadystep = 0
		var/tmp/mob/owner
		var/max_range = 10 // Range that clone can be far away
		var/min_range = 0 // Still don't coded the minimum range
		Cross(mob/a)
			if(istype(a,/mob))
				if(a.client && a.jump==FALSE)
					return 0
				else
					return 1
			if(istype(a,/mob/ShadowClone))
				var/mob/ShadowClone/Z = a
				if(Z.density == 1)
					if(Z.ownerkey == src.ownerkey)
						return 1
		Del()
			owner.shadowclonelist -= src
			Poof(src.x,src.y,src.z)
			..()
mob
	var
		tmp
			tajuuclone = 0
			attackablenpc = 0
			clone = 0
mob/var/tmp/list/shadowclonelist = list()
obj/effect
	New()
		spawn(10)
		del(src)
proc/Poof(dx,dy,dz)
	spawn()
		var/obj/o = new/obj/effect(locate(dx,dy,dz))
		o.icon='smokejutsu.dmi'
		spawn(8)
			del(o)
mob/proc/Shadowclone()
	if(src.clone==1)
		for(var/mob/ShadowClone/O in shadowclonelist)
			if(O.ownerkey==usr.key)
				del(O)
		clone = 0
	clone = 1
	for(var/turf/x in orange(1))
		if(!x.density)
			var/mob/ShadowClone/O=new(x)
			src.shadowclonelist += O
			O.icon=src.icon
			O.icon_state = src.icon_state
			O.overlays+=src.overlays
			O.underlays+=src.underlays
			O.bound_y = src.bound_y
			O.bound_x = src.bound_x
			O.name=src.name
			O.step_size = src.step_size
			O.ownerkey=src.key
			O.owner = src
//			O.follow()
			Poof(O.x,O.y,O.z)
			sleep(0.03)
mob
	Move()
		set waitfor = 0
		. = ..()
/*    if(next_move>worldtime) return 0
    . = ..()
    next_move = world.time + move_delay
*/
		if(src.client)
			if(src.clone==1)
				for(var/mob/ShadowClone/O in shadowclonelist)
					step(O,src.dir)
					if(get_dist(O, O.owner) >= O.max_range)
						del(O)