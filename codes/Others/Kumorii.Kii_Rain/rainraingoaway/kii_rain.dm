
/*
		This is a simple library that includes a very simple yet aesthetic method of adding rain to your world. CPU usage shouldn't be problematic
	as I've been using this method for sometime now in my own project. I hope this proves useful to someone and that it bumps the quality bar for BYOND
	just a little bit higher. Good luck and happy deving! -Kumo

	HOW TO USE:
	1.		In the map editor you will find a new area type called "rainy area". You will draw this area over your map wherever you would like it
		to rain.
	2.		Make sure you have rain_loop() plugged into your world/New() procedure(see demo stuff below for an example).
	3.		Compile and run!

		NOTES:

			[11/23/15] --- I updated the library so that it no longer requires a bit of time to preload and starts working right away.
								Rain will also now fall randomly instead of only falling on tiles that got automatically selected.
						I want to work a bit more with this since right now it's not possible to to have "heavy rain" without maxing out the cpu.

*/


#define RENDER_WEATHER 1		// toggle to 0 if you want to disable the rain for any reason.

var/tmp
	list/rainy_turfs= list()	// this will be a list of all the turfs that have the rain animation set on them.
	list/snow_turfs= list()
								// ** you COULD utilize this to "toggle the rain" with little effort.
proc
	rain_loop()
		set waitfor = 0
		if(!RENDER_WEATHER) return
		if(rainy_turfs.len)
			for()										// an empty for() loop is faster than a while().
				var/i 		= rand(1,rainy_turfs.len)	// pick random tiles from the total pool of rainy turfs.
				var/turf/t	= rainy_turfs[i]
				rainy_turfs -= t						// remove the turf from the list so that multiple rain drops don't spawn on the same turf at once.
				t.rain()
				rainy_turfs += t						// readd the turf for future rain.
				sleep world.tick_lag

turf
	proc
		snow()
			var/obj/weather/r 	= new /obj/weather/snow	// I use object pooling instead of calling new.. I suggest you do the same!
			r.loc 				= src
			animate(r,icon_state = "snow1", pixel_y = 300, pixel_x = 0, alpha = 155, loop = 1)
			animate(pixel_y	= 5, pixel_x = pick(-1,10), time = 16.8)
			animate(icon_state = "snow2", time = rand(1.2, 4.8))
			spawn(27) del r								// again, I'd recollect the rain for recycling instead of deleting it.
proc
	snow_loop()
		set waitfor = 0
		if(!RENDER_WEATHER) return
		if(snow_turfs.len)
			for()										// an empty for() loop is faster than a while().
				var/i 		= rand(1,snow_turfs.len)	// pick random tiles from the total pool of rainy turfs.
				var/turf/t	= snow_turfs[i]
				snow_turfs -= t						// remove the turf from the list so that multiple rain drops don't spawn on the same turf at once.
				t.snow()
				snow_turfs += t						// readd the turf for future rain.
				sleep world.tick_lag

turf
	proc
		rain()
			var/obj/weather/r 	= new /obj/weather/rain	// I use object pooling instead of calling new.. I suggest you do the same!
			r.loc 				= src
			animate(r,icon_state = "rain", pixel_y = 400, pixel_x = 0, alpha = 155, loop = 1)
			animate(pixel_y	= 5, pixel_x = pick(-10,10), time = 10.8)
			animate(icon_state = "rainland", time = rand(1.2, 4.8))
			spawn(17) del r								// again, I'd recollect the rain for recycling instead of deleting it.


obj/weather
	icon	= 'x16.dmi'
	layer	= EFFECTS_LAYER+11
	rain
		icon_state	= "rain"
	snow
		icon_state = "snow1"


area
	rainy_area
		icon				= 'x16.dmi'
		icon_state			= "rainmarker"		// the area will be deleted after runtime so the state is just to aid with mapping in the .dmm editor.
		layer				= EFFECTS_LAYER
		appearance_flags	= NO_CLIENT_COLOR
		New()
			..()
			for(var/turf/t in contents)
				rainy_turfs += t
			del src
	snow_area
		icon				= 'x16.dmi'
		icon_state			= "snowmarker"		// the area will be deleted after runtime so the state is just to aid with mapping in the .dmm editor.
		layer				= EFFECTS_LAYER
		appearance_flags	= NO_CLIENT_COLOR
		New()
			..()
			for(var/turf/t in contents)
				snow_turfs += t
			del src





/////////////
		// Everything below here is only important for the demo.



world
	New()
		..()
		rain_loop()		// It's important you plug this in here!


turf/grass
	icon		= 'x16.dmi'
	icon_state	= "grass"













