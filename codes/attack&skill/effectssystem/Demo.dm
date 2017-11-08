
// This code is just to put together the demo world.
// What you really want to be looking at is in the
// Examples.dm file.
/*
area
	luminosity = 0
*/


mob/Stat()
	statpanel("Effects")
	if(istype(src.fm_effects_list, /list))
		for(var/effect/E in src.fm_effects_list)
			stat("[E.type]", "[E.lifetime * E.cycle_time] ticks")