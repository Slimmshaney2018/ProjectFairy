
/*

derpy derpy doo

*/
//mob
//	Login()
//		..()
//		draw_planes()
mob
	proc
		draw_planes()	 // must apply this when the player logs in to add the lighting planes/overlays/etc. to the client's screen/character
			toggle_daynight(1)
			client.screen += new/obj/lighting_plane
//			draw_spotlight(-38, -38, "#FFFFFF", 1, 255)
			draw_spotlight(-24, -12, "#FFFFFF", 1, 255)


atom/movable
	var
		image/spotlight	// null by default because not everything will have one, obvi
	proc
		draw_spotlight(x_os = 0, y_os = 0, hex = "#FFFFFF", size_modi = 1, alph = 255)
			/* x_offset, y_offset, color value (if any)
				*/
			spotlight 			= new /image/spotlight
			spotlight.pixel_x	= x_os
			spotlight.pixel_y	= y_os
			spotlight.color		= hex
			spotlight.transform	= matrix()*size_modi
			spotlight.alpha		= alph
			overlays += spotlight


obj/lighting_plane
	screen_loc 			= "1,1"
	plane 				= 1
	blend_mode 			= BLEND_MULTIPLY
	appearance_flags 	= PLANE_MASTER | NO_CLIENT_COLOR
	mouse_opacity 		= 0


image/spotlight
	plane 			= 1
	blend_mode 		= BLEND_ADD
	icon 			= 'lighting.dmi'  // a 96x96 white circle ; you can change this to whatever lighting aura you want.
	icon_state 		= "0"
	pixel_x 		= -38
	pixel_y 		= -38
	layer			= 1+EFFECTS_LAYER
	appearance_flags= RESET_COLOR





////////////////////////////////////////
//////////////////   ambient lighting stuff
//////////////
///  you can easily figure out how to animate/adjust the lighting to your liking.

var/max_darkness = 225
mob/verb
	toggle_daynight1()
		toggle_daynight(0)
mob
	var/tmp
		obj/hud/daynight/daynight = new
	proc
		toggle_daynight(i = 0)
			/* call this to enable or disable the day/night effect for a given player.
				src.toggle_daynight(1) will enable day/night.
				src.toggle_daynight() AND src.toggle_daynight(0) will disable day/night.
			*/
			if(i) client.screen.Add(daynight)
			else	client.screen.Remove(daynight)


obj/hud

	daynight
		/*	this is a HUD object that gets cast across client.screen so day/night effects can be easily enabled/disabled for different players depending on their
			location and such. (for example, if you're inside a cave, it shouldn't be sunny. Or if you're in a lit house at night, it shouldn't stay dark when you go inside.
			*/
		icon			= 'weather.dmi'
		icon_state		= "black"
		screen_loc		= "SOUTHWEST to NORTHEAST"
		plane			= 1
		mouse_opacity 	= 0
		alpha			= 154 // this is how dark you want your lighting to be
//		alpha = 112