/////////////////////////////////////////Changes the define for another walk speed value////////////////////////////////////////////
#define DEFAULT_WALK 3
#define DEFAULT_RUN 7
#define DEFAULT_DASHWALK 6 // Then dashing with walk
#define DEFAULT_DASHRUN 10 // Then you dash at run


mob/var
	tmp/jump = FALSE
	tmp/highjump = 0
	tmp/spamprotection = 0
	running = 0
obj
	map
		Jumpthing
			density = 0
			icon = 'humanbase.dmi'
			Cross(mob/a)
				if(istype(a,/mob))
					if(a.jump==FALSE)
						return 0
					else
						return 1
mob/proc
	Jump()
		set waitfor = 0
		if(jump==FALSE)
			jump = TRUE
			spawn(2) highjump = 1
//			spawn(2) newocc(src, "You cant get damaged at this point of jump", rgb(150,50,10))
			if(src.clone==1)
				for(var/mob/ShadowClone/O in oview())
					O.Jump()
			while(pixel_y < 70)
				pixel_y += 7// if you want make fast add more number, slower less number
				sleep(0.01)
			while(pixel_y != 0)
				pixel_y -= 9// if you want make fast add more number, slower less number
				if(pixel_y < 0)
					pixel_y = 0
				sleep(0.01)
			highjump = 0
//			newocc(src, "Now you can get damaged at this point of jump", rgb(150,50,10))
			spawn(1)
			jump = FALSE
			highjump = 0
	Run()
		if(running==1)
			src.step_size = DEFAULT_WALK
			src.icon_state = ""
			if(client) newocc(src, "You stopped to run", rgb(50,250,100))
			src.running = 0
			if(src.clone==1)
				for(var/mob/ShadowClone/O in shadowclonelist)
					O.Run()
		else if(running==0)
			src.icon_state = "Run"
			src.step_size = DEFAULT_RUN
			if(client) newocc(src, "You start to run", rgb(50,250,100))
			src.running = 1
			if(src.clone==1)
				for(var/mob/ShadowClone/O in shadowclonelist)
					O.Run()
mob
	proc
		Dash_Effect(location)
			var/obj/effect/d1 = new(/**/)
			d1.name = "[src] Dashed"
			d1.overlays = src.overlays
			d1.underlays = src.underlays
			d1.icon = src.icon
			d1.icon_state = src.icon_state
			d1.dir = src.dir
			d1.loc = location
			d1.alpha=100
			d1.pixel_x = src.pixel_x
			d1.pixel_y = src.pixel_y
			d1.step_x = src.step_x
			d1.step_y = src.step_y
			d1.step_size = src.step_size
			spawn(5) del(d1)
mob
	var/tmp/dashing = FALSE
	proc/Dash()
		set waitfor = 0
		if(dashing) return
		dashing = TRUE
		var/oldstepsize = src.step_size
		if(src.running == 0) step_size = DEFAULT_DASHWALK
		if(src.running == 1) step_size = DEFAULT_DASHRUN//15 // It should be highter than running step_size, because the dash would be used for more faster
		if(istype(src,/mob/ShadowClone))
			step_size -= 3
		if(src.step_size > DEFAULT_DASHRUN)
			src.step_size = DEFAULT_DASHRUN
		if(src.clone==1)
			for(var/mob/ShadowClone/O in shadowclonelist)
				O.Dash()
		for(var/i in 1 to 15)//1 to 15
			Dash_Effect(loc)
			step(src, dir)
			sleep world.tick_lag
		dashing = FALSE
		src.step_size = oldstepsize