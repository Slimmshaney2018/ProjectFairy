
/*
				:: Maptext Nametags by Kumorii

************************

		So this is a really simple bit of code I put together a few months ago but never really used. There are no issues that I'm aware of and
	editing/improving it should be effortless. If requested, I may revisit this and add some tweaks for color or something. Use it as you wish!

**********************

			:: How to use ::

		When you want to draw a nametag simply call src.draw_nametag("display name").  src being the atom that is recieving the nametag.
	if you want to change the text displayed, call src.nametag.change_text("new name") and that's it!

**********************																																*/

atom/movable

	var/obj/nametag/nametag

	proc/draw_nametag(name_text)
		/*
			called to draw a new nametag for [src].
		*/
		nametag	= new /obj/nametag("[name_text]")
		overlays += nametag



obj/nametag
	maptext_width		= 128
	maptext_height		= 18
	pixel_y				= -10	// x and y offsets to center the maptext bounds on src. totes obvi.
	pixel_x				= -54
	layer				= FLOAT_LAYER
	var/disp_text	// The text to be displayed. can be removed, honestly. It's just there to simplify future ideas.

	New(t)
		..()
		if(t) change_text(t)



	proc
		change_text(new_text)
			/*
				called to change an existing nametag's display text.
					new_text	- the new text to be output.
			*/
			disp_text	= "[copytext(new_text,1,16)]"
			maptext		= "<td align=center><font size = 1>[disp_text]"