client
	var
		// Create new instances of backgrounds and display HUDs
		// whenever a new client is created.
		obj/hud_background/background = new()
		display_hud/backpack/backpack = new()
		tmp/backopen = 0
mob/verb
	AbrirMochila()
		set hidden=1, instant = 1
		client.CallBackgound()
client/proc
	CallBackgound()
		if(backopen==0)
			src.screen += src.background
			screen += new /obj/hud/Skill_backgound
			for(var/obj/Skillcards/Skills/O in usr.contents)
				src.backpack.Add(src, O, src.screen)
			backopen = 1
		else
			src.screen -= src.background
			for(var/obj/hud/Skill_backgound/S in src.screen)
				del S
			for(var/obj/Skillcards/Skills/O in usr.contents)
				src.backpack.Remove(src, O, src.screen)
			backopen = 0

mob
	verb/Get(/*obj/O as obj in view(src, 1)*/)
		set hidden=1, instant = 1
		for(var/obj/Skillcards/O in view(src,0))
			if(istype(O,/obj/Skillcards))
				if(src.client.backpack.Add(src, O, src.contents))
					newocc(src, "You acquired [O]!")
					if(!techniques) techniques=new
					techniques[O.name]=O
				else
					newocc(src,"You don't have any more room!")
mob
	verb/Drop(obj/O as obj in src.contents)
		if(src.client.backpack.Remove(src, O, src.contents))
			O.loc = src.loc
			src << "You dropped [O]."
		else
			src << "You can not drop [O]!"
// Background objects (not important)
obj/hud_background
	icon = 'icon11.dmi'
	icon_state = "background"
	screen_loc = "26,10 to 30,16"
	alpha = 155
	layer = TURF_LAYER
obj/hud/Skill_backgound
	icon = 'Skillsbackground.dmi'
	screen_loc = "24.3,11.828"
	alpha = 230
	layer = TURF_LAYER
	New()
		animate(src, transform = matrix()*0.62, time = 1)




// Display HUD Datums
display_hud/backpack
	// Starting screen_loc is the top left corner where objects begin accumulating.
	// If start_x is 5 and start_y is 8, the starting screen_loc will be "5,8"
	start_x = 26
	start_y = 16

	// Ending screen_loc is the bottom right corner where the display list ends.
	// If end_x is 5 and end_y is 8, the final screen_loc will be "5,8"
	end_x = 30
	end_y = 10

	// If these values are used, pixel offsets for x and y values will be appended
	// to each of the screen_locs used by the hud.
	pixel_offset_x = 0
	pixel_offset_y = 0

	// If this is true, objects will be added by column first instead of by rows.
	vertical = 0


// Functions for adding and removing objects from any of the
// display HUD lists.
/*client/verb/AddItem(listname as text)

	var/obj/O = new()
	O.icon = 'icon.dmi'

	var/list/L
	var/display_hud/HUD
	switch(listname)
		if("backpack")
			L = mob.contents
			HUD = src.backpack
			O.icon_state = "item[rand(1,4)]"
	if(HUD.Add(src, O, L))
		newocc(world,"Item added!")
	else
		newocc(world,"Item was not added.")


client/verb/RemoveItem(listname as text)
	var/list/L
	var/display_hud/HUD
	switch(listname)
		if("backpack")
			L = mob.contents
			HUD = src.backpack
	if(!L.len)
		return
	var/atom/movable/A = pick(L)
	if(!A)
		return
	if(HUD.Remove(src, A, L))
		world << "Item removed!"
	else
		world << "Item was not removed."
*/


