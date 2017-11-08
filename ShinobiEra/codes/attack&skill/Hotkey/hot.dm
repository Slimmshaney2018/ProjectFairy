/*mob
	var/list
		hudobjects=list()
		acquired_skills=list()

	proc
		LoadSkills()//call this after loading the save file, and after you have repopulated the HUD with the hotkeys
			for(var/obj/Skillcards/Skills/O in acquired_skills)//check through all of the learned skills
				if(O.id)//if any of these skills have an id, this means the skill was equipped the last time the game was saved
					for(var/obj/Skillcards/Skills/H in hudobjects)//check through all of the hotkeys onscreen
						if(H.id==O.id)  H.Skilladd(O,src)//if the unique id of the hotkey is the same as the id of the skill,
                                                         //add the skill to that hotkey

mob
	proc/LoadSkillCards()
		for(var/obj/Keys/O in screen_loc)
			var/obj/Skillcards/H=HotKeys
			if(H.sid==O.id)
				H.MouseDrop(O,src)
mob
	verb/testloadskils()
		LoadSkillCards()
		LevelUP_notification()
*/
var/list/abilities = singleton_init(/ability) //this function from Ter13.StdLib allows you to initialize one of each subtype that has an id variable set to a value.

ability
	parent_type = /obj
	var
		id
	proc
		Use(mob/user,mob/target)

	MouseDrop(atom/over_object,atom/src_location,atom/over_location,src_control,over_control,params)
		if(istype(over_object,/screen_obj/hotslot))
			var/screen_obj/hotslot/slot = over_object
			slot.Update(src)
screen_obj
	parent_type = /obj
	hotslot
		var
			position
			stored_appearance
		Click()
			if(position)
				usr.Hotkey(position)
		MouseDrop(atom/over_object,atom/src_location,atom/over_location,src_control,over_control,params)
			if(istype(over_object,/screen_obj/hotslot))
				var/screen_obj/hotslot/slot = over_object
				usr.hotslots.Swap(position,slot.position)
			else
				usr.hotslots[position] = null

		Update(ability/ability)
			if(stored_appearance) overlays -= stored_appearance
			if(ability)
				overlays += (stored_appearance = ability.appearance)
				usr.hotslots[position] = ability.id

		New(screen_loc,position)
			src.position = position
			src.screen_loc = screen_loc
			..()
mob
	var
		list/hotslots = new/list(10)
	proc
		Hotkey(position)
		var/id = hotslots[position]
		if(id)
			var/ability/ability = global.abilities[id]
			if(ability)
				ability.Use()
client
	var
		list/hotbar
	New()
		. = ..()
		if(.)
			BuildHotbar()

	proc
		BuildHotbar()
			var/screen_obj/hotslot/slot, list/bar = mob.hotslots, id
			hotbar = list()
			for(var/pos in 1 to 10)
				slot = new/screen_obj/hotslot("CENTER+0:[(count - 5) * TILE_WIDTH],SOUTH",pos)
				id = bar[pos]
				if(id)
					ability = abilities[id]
					if(ability)
						slot.Update(ability)
				hotbar += slot
			screen += hotbar