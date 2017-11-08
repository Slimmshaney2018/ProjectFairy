mob
	var
		hp = 1000
		max_hp = 1000
		mana = 100
		max_mana = 100
		str = 100
		int = 1
		dex = 1
		con = 1
		def = 1
		wounds=2
		current_area
		weapon = "shuriken"
		kunais
		can_move = 1
mob
	var
		tmp/vinespeed=0
		tmp/stone=0
		tmp/fireball=0
		tmp/icicle=0
		tmp/blazed=0
		tmp/tombstone_drop
		tmp/tombstones = list()
		tmp/turf/origin_loc
		tmp/can_be_projectile=1
atom
	var/tmp/standing = 1
/*mob
	proc/myArea()
		for(var/area/zones/A in orange(0,src))
			current_area = A.name
			return A
	proc/dojo()
		for(var/area/dojo/A in orange(0,src))
			return 1*/
area
	dojo
	zones
obj
	wandercantpass
		density = 0
		Cross(atom/movable/a)
			if(istype(a,/mob/wandercam))
				return 0
			else
				return 1
obj
	tombstone