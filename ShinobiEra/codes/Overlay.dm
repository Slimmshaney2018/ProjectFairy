client
	Stat()
		if(src.mob.contents)
			statpanel("Bag")
			for(var/obj/item/i in src.mob.contents)
				stat(i)
mob/verb
	ViewEquip()
		usr<<"[equipment]"
obj
	item
		var/equipped = FALSE
		list/equipment
		verb
			get()
				set src in oview(1)
				src.Move(usr)
		verb
			equi1p()
				equip()
				equipped()
		proc
			equip()
				if(ismob(src.loc))
					var/mob/m = src.loc
					if(!m.equipment.Find(src))
						. = m.equip(src)
						if(!.)
							src.equipped = FALSE
							usr<<"unequip"
						else
							src.equipped(m)
							usr<<"equip"
					else
						src.equipped = FALSE
			equipped(var/mob/m)
				m.equip(src)
		Read(var/savefile/F)
			. = ..(F)
			if(src.equipped==TRUE)
				src.equip()

mob
	var
		tmp/list/equipment = list()
		list/equipment_slots = list("head","chest","left foot","right foot","finger1","finger2")
	proc
		equip(var/obj/item/equipment/e)
			return 1
		equipped(var/obj/item/equipment/e,var/slot=null)
			if(slot!=null)
				src.equipment[slot] = e
			else
				src.equipment.Add(e)
				usr<<"equip[e]"

obj
	item
		equipment
			slotted
			verb
				See()
					usr<<"Slot:[slot]"
				var/slot
				equipped(var/mob/m)
					if(src.slot!=null)
						if(copytext(src.slot,-1)=="#")
							var/testpos = 1
							slot = copytext(slot,1,length(slot)-1)
							var/testslot = "[slot][testpos]"
							while(m.equipment[testslot]!=null)
								testslot = "[slot][++testpos]"
							if(m.equipment_slots.Find(testslot))
								src.slot = testslot
								usr<<"passounoequip[testslot]"
								m.equipped(src,src.slot)
								return 1
					else
						if(m.equipment[slot]==null)
							m.equipped(src,src.slot)
							return 1
					return 0
obj/item/equipment/slotted/ring
	icon = 'ring.dmi'
	slot = "head"

obj/item/equipment/slotted/ring2
	icon = 'ring.dmi'
	slot = "chest"