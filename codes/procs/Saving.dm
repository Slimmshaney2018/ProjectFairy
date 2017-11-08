#define HAT_LAYER     FLOAT_LAYER
#define SHIRT_LAYER   FLOAT_LAYER-0.01
#define PANTS_LAYER   FLOAT_LAYER-0.02
#define SHOES_LAYER   FLOAT_LAYER-0.03
var/list/race_icons = list("base" = 'humanbase.dmi'//,
//								"undead" = 'undead.dmi',
//								"robot" = 'robot.dmi'
)
var/list/hair_icons = list("normal" = 'normalhair.dmi'//,
//								"undead" = 'undead.dmi',
//								"robot" = 'robot.dmi'
)
mob
	var/race_icon = "base"  // default value
	var/hairstyle = "normal"
	var/haircolor = "#333333"
mob/proc/BuildIcons()
	var/icon/main = new(race_icons[race_icon || "base"])
	var/icon/hair = new(hair_icons[hairstyle || "hair"])
//	var/icon/hair = new('normalhair.dmi', hairstyle)
	// red component becomes custom color, green becomes highlight
	hair.MapColors(haircolor, "#ffffff", "#000000", "#000000")
	main.Blend(hair, ICON_OVERLAY)
	icon = main
mob/proc/BuildEquipmentOverlays()
	overlays.Cut()
	var/obj/olay = new
	for(var/obj/item/O in equipment)
		if(O.equipped==1)
//		if(O.has_overlay)
			olay.icon = O.icon
			olay.icon_state = "equipped"
//			olay.layer = (O.equipment_layer || FLOAT_LAYER)
			if(O.visualtype=="Hat")
				olay.layer = HAT_LAYER
			if(O.visualtype=="Shirt")
				olay.layer = SHIRT_LAYER
			if(O.visualtype=="Pants")
				olay.layer = PANTS_LAYER
			if(O.visualtype=="Shoes")
				olay.layer = SHOES_LAYER
			overlays += olay
			usr<<"BuildEquipmentDone"

// update this any time you need to change the savefile format
#define SAVEFILE_VERSION 1
mob/var/tmp/savefile_version// you don't need to load this--make it /tmp

mob/Write(savefile/F)
	// save version info with the character
	F["savefile_version"] << SAVEFILE_VERSION
	..()
	F["icon"] << null
	F["overlays"] << null
	F["underlays"] << null
mob/Read(savefile/F)
	var/version
	F["savefile_version"] >> version
	if(isnull(version)) version = 0
  // do the normal read
	..()
	var/resave
	if(version  <100)
		usr<<"Hi! You're playing Version [SAVEFILE_VERSION] savefile"
/*	if(version < 8)   // back when all the stats were huge...
		strength = round(strength * 0.4, 1)
		resave = 1*/
	if(resave)
	// re-save the character
		Write(F)
	BuildIcons()      // now we set up the icons when we load
//	BuildEquipmentOverlays()
mob/proc
	saveprocess()
		var/whitelist = list("tag", "desc", "suffix", "text","icon","icon_state",
							"luminosity", "opacity", "density", "layer", "mouse_over_pointer", "mouse_drag_pointer", "mouse_drop_pointer",
							"mouse_drop_zone", "invisibility", "infra_luminosity", "pixel_x", "pixel_y", "pixel_z", "maptext",
							"maptext_width", "maptext_height", "sight", "see_in_dark", "see_invisible", "see_infrared", "screen_loc",
							"bounds", "step_x", "step_y", "step_size", "glide_size","overlays","underlays","bound_height","bound_width",
							"techniques") // things to not save, important: we should not save icons and overlays
		var/savefile/f = new("Saves/players/[src.ckey].sav")
		if(f)
			for(var/v in src.vars)
				if(!issaved(src.vars[v]) || (v in whitelist))
					continue
				f[v] << src.vars[v]
			f["x"] << src.x
			f["y"] << src.y
			f["z"] << src.z
			f["savefile_version"] << SAVEFILE_VERSION
/*			f["icon"] << null
			f["overlays"] << null
			f["underlays"] << null*/
	loadprocess()
		client.eye = src
		client.perspective = MOB_PERSPECTIVE
		src.client.StartHotkeys()
		src.removeHud()
            // basic load process
		var/whitelist = list("tag", "desc", "suffix", "text","icon","icon_state",
							"luminosity", "opacity", "density", "layer", "mouse_over_pointer", "mouse_drag_pointer", "mouse_drop_pointer",
							"mouse_drop_zone", "invisibility", "infra_luminosity", "pixel_x", "pixel_y", "pixel_z", "maptext",
							"maptext_width", "maptext_height", "sight", "see_in_dark", "see_invisible", "see_infrared", "screen_loc",
							"bounds", "step_x", "step_y", "step_size", "glide_size","overlays","underlays","bound_height","bound_width",
							"techniques")
		var/savefile/f = new("Saves/players/[src.ckey].sav")
		var/version
		f["savefile_version"] >> version
		if(isnull(version)) version = 0
		for(var/v in src.vars)
			if(!issaved(src.vars[v]) || (v in whitelist))
				continue
			f[v] >> src.vars[v]
		var/resave
		if(version  < 1)
			usr<<"nerf on you"
		src.loc = locate(f["x"], f["y"], f["z"])
		src.BuildIcons()      // now we set up the icons when we load
		src.BuildHotbar()
		src.draw_nametag("[src.name]")
//		src.BuildEquipmentOverlays()
		if(resave)
			saveprocess()
mob/proc
	BuildHotbar()
		for(var/obj/Skillcards/Skills/Z in src.contents)
			if(Z.equippedthing==1)
				src.client.screen+=Z
				Z.screen_loc = Z.screenlocation
				if(!techniques) techniques=new
				techniques[Z.name]=Z