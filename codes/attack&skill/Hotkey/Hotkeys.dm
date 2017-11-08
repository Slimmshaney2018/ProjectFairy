mob
	Login()
		.=..()
		InitInputHandler()
	proc/InitInputHandler()
		var/const/macro_id = "macro"
		winset(client, "anykey", @|parent=|+macro_id+@|;name=Any;command='KeyPressed "[[*]]"';|)
		winset(client, "anykeyup", @|parent=|+macro_id+@|;name=Any+UP;command='KeyReleased "[[*]]"';|)
client
	var
		tmp/Wactive = 0
		tmp/Sactive = 0
		tmp/Dactive = 0
		tmp/Aactive = 0
		tmp/umactive = 0
		tmp/doisactive = 0
		tmp/tresactive = 0
		tmp/quatroactive = 0
		tmp/cincoactive = 0
		tmp/sixactive = 0
		tmp/sevenactive = 0
		tmp/ochoactive = 0
		tmp/nineactive = 0
		tmp/dezactive = 0
		tmp/Eactive = 0
		tmp/Factive = 0
		tmp/igualactive = 0
		tmp/negactive = 0
		tmp/Ractive = 0
	verb/KeyPressed(key as text)
		set hidden = 1, instant = 1
		if(key == "W")
			repeatw
			Wactive = 1
			step(mob,NORTH)
			sleep(world.tick_lag)
			if(Wactive==1) goto repeatw
		if(key == "S")
			repeatS
			Sactive = 1
			step(mob,SOUTH)
			sleep(world.tick_lag)
			if(Sactive==1) goto repeatS
		if(key == "D")
			repeatD
			Dactive = 1
			step(mob,EAST)
			sleep(world.tick_lag)
			if(Dactive==1) goto repeatD
		if(key == "A")
			repeatA
			Aactive = 1
			step(mob,WEST)
			sleep(world.tick_lag)
			if(Aactive==1) goto repeatA
		if(key == "1")
			repeat1
			umactive = 1
			mob.UseKey("Key1")
			sleep(world.tick_lag)
			if(umactive==1) goto repeat1
		if(key == "2")
			repeat2
			doisactive = 1
			mob.UseKey("Key2")
			sleep(world.tick_lag)
			if(doisactive==1) goto repeat2
		if(key == "3")
			repeat3
			tresactive = 1
			mob.UseKey("Key3")
			sleep(world.tick_lag)
			if(tresactive==1) goto repeat3
		if(key == "4")
			repeat4
			quatroactive = 1
			mob.UseKey("Key4")
			sleep(world.tick_lag)
			if(quatroactive==1) goto repeat4
		if(key == "R")
			repeat5
			cincoactive = 1
			mob.UseKey("Key5")
			sleep(world.tick_lag)
			if(cincoactive==1) goto repeat5
		if(key == "Q")
			repeat6
			sixactive = 1
			mob.UseKey("Key6")
			sleep(world.tick_lag)
			if(sixactive==1) goto repeat6
		if(key == "C")
			repeat7
			sevenactive = 1
			mob.UseKey("Key7")
			sleep(world.tick_lag)
			if(sevenactive==1) goto repeat7
		if(key == "X")
			repeat8
			ochoactive = 1
			mob.UseKey("Key8")
			sleep(world.tick_lag)
			if(ochoactive==1) goto repeat8
		if(key == "F")
			repeatF
			Factive = 1
			mob.UseKey("Key9")
			sleep(world.tick_lag)
			if(Factive==1) goto repeatF
		if(key == "E")
			repeatE
			Eactive = 1
			mob.UseKey("Key10")
			sleep(world.tick_lag)
			if(Eactive==1) goto repeatE
		if(key == "Z")
			repeatigual
			igualactive = 1
			mob.UseKey("Key11")
			sleep(world.tick_lag)
			if(igualactive==1) goto repeatigual
		if(key == "R")
			repeatneg
			negactive = 1
			mob.UseKey("Key12")
			sleep(world.tick_lag)
			if(negactive==1) goto repeatneg
		if(key == "'")
			repeatR
			Ractive = 1
			mob.UseKey("Key0")
			sleep(world.tick_lag)
			if(Ractive==1) goto repeatR
		if(key == "Escape")
			src.ToggleFullscreen()
//		if(key == "C")
//			usr.chat_world()
		if(key == "Space")
			usr.Jump()
		if(key == "G")
			usr.Get()
		if(key == "H")
			usr.AbrirMochila()
	verb/KeyReleased(key as text)
		set hidden = 1, instant = 1
		if(key == "W")
			src.NorthReleased()
			Wactive = 0
		if(key == "S")
			src.SouthReleased()
			Sactive = 0
		if(key == "D")
			src.EastReleased()
			Dactive = 0
		if(key == "A")
			src.EastReleased()
			Aactive = 0
		if(key == "1")
			umactive = 0
		if(key == "2")
			doisactive = 0
		if(key == "3")
			tresactive = 0
		if(key == "4")
			quatroactive = 0
		if(key == "R")
			cincoactive = 0
		if(key == "Q")
			sixactive = 0
		if(key == "C")
			sevenactive = 0
		if(key == "X")
			ochoactive = 0
		if(key == "F")
			Factive = 0
		if(key == "E")
			Eactive = 0
		if(key == "Z")
			igualactive = 0
		if(key == "R")
			negactive = 0
		if(key == "'")
			Ractive = 0
mob
	var/list
		HotKeys=list(,"Key0","Key1","Key2","Key3","Key4","Key5","Key6","Key7","Key8","Key9","Key10","Key11","Key12")

	verb/UseKey(key as text)
		set hidden=1, instant = 1
		if(HotKeys[key])
			var/obj/Skillcards/O=HotKeys[key]
			O.Initiate(src)
	proc/SetKey(key,object) HotKeys[key]=object
client/proc/StartHotkeys()
	new/obj/Numbers/Key0(src)
	new/obj/Numbers/Key1(src)
	new/obj/Numbers/Key2(src)
	new/obj/Numbers/Key3(src)
	new/obj/Numbers/Key4(src)
	new/obj/Numbers/Key5(src)
	new/obj/Numbers/Key6(src)
	new/obj/Numbers/Key7(src)
	new/obj/Numbers/Key8(src)
	new/obj/Numbers/Key9(src)
	new/obj/Numbers/Key10(src)
	new/obj/Numbers/Key11(src)
	new/obj/Numbers/Key12(src)
	new/obj/Keys/Key0(src)
	new/obj/Keys/Key1(src)
	new/obj/Keys/Key2(src)
	new/obj/Keys/Key3(src)
	new/obj/Keys/Key4(src)
	new/obj/Keys/Key5(src)
	new/obj/Keys/Key6(src)
	new/obj/Keys/Key7(src)
	new/obj/Keys/Key8(src)
	new/obj/Keys/Key9(src)
	new/obj/Keys/Key10(src)
	new/obj/Keys/Key11(src)
	new/obj/Keys/Key12(src)

obj/Keys
	layer=10
	icon='Hotkeys.dmi'
	icon_state = ""
	var/locc
	var/id
	alpha = 155
	DblClick()
		usr.HotKeys[name]=null
	New(client/C)
		screen_loc=locc
		C.screen+=src
	Key0
		locc = "2,1"
	Key1
		locc = "3,1"
	Key2
		locc = "4,1"
	Key3
		locc = "5,1"
	Key4
		locc = "6,1"
	Key5
		locc = "7,1"
	Key6
		locc = "8,1"
	Key7
		locc = "9,1"
	Key8
		locc = "10,1"
	Key9
		locc = "11,1"
	Key10
		locc = "12,1"
	Key11
		locc = "13,1"
	Key12
		locc = "14,1"
obj/Numbers
	layer=25
	icon='Hotkeys.dmi'
	var/locc
	New(client/C)
		screen_loc=locc
		C.screen+=src
	Key0
		icon_state = "'"
		locc = "2,1"
	Key1
		icon_state = "1"
		locc = "3,1"
	Key2
		icon_state = "2"
		locc = "4,1"
	Key3
		icon_state = "3"
		locc = "5,1"
	Key4
		icon_state = "4"
		locc = "6,1"
	Key5
		icon_state = "5"
		locc = "7,1"
	Key6
		icon_state = "6"
		locc = "8,1"
	Key7
		icon_state = "7"
		locc = "9,1"
	Key8
		icon_state = "8"
		locc = "10,1"
	Key9
		icon_state = "9"
		locc = "11,1"
	Key10
		icon_state = "0"
		locc = "12,1"
	Key11
		icon_state = "="
		locc = "13,1"
	Key12
		icon_state = "R"
		locc = "14,1"
obj
	var
		screenlocation
	Skillcards
		layer = 12
		var
			SkillType = "None"
			sid
			position
			stored_appearance
		New()
			..()
			src.mouse_drag_pointer = icon(src.icon,src.icon_state)
		DblClick()
			usr.HotKeys[name]=null
			usr.client.screen -= src
			src.screenlocation = null
			src.equippedthing = 0
		MouseDrag()
			usr.HotKeys[name]=null
		MouseDrop(obj/Slot)
/*			var/list/found = list()
			for(var/obj/Skillcards/Skills/t in usr.contents)
				found += t
				if(found.len>=require)
					break
			if(found.len<require) return*/
			var/obj/Skillcards/Skills/t = locate(/obj/Skillcards/Skills) in usr.contents
			if(!t) return
			if(Slot)
				src.name = Slot.name
				usr.client.screen += src
				src.screen_loc=Slot.screen_loc
				src.screenlocation = src.screen_loc
				src.equippedthing = 1
				usr.SetKey(Slot.name,src)
				if(istype(Slot,/obj/Skillcards))
					usr.client.screen -= Slot
					Slot.equippedthing = 0
					Slot.screenlocation = null
			else
				..()
				usr.HotKeys[name]=null
				src.equippedthing = 0
		MouseDrop(src)
			if(istype(src,/obj/Keys)||istype(src,/obj/Skillcards/Skills))// must be a skillcard being dropped onto a key
				..()
			else
				return
	Skillcards
		var
			mana_cost = 1
			cd = 10
			tmp/canuseskill = 1
			tmp/spam = 0
			InitialName
		proc/Initiate(mob/Owner)
			if(Owner.mana >= 0 && Owner.mana >= mana_cost && canuseskill==1)
				Owner.mana -= src.mana_cost
				usr.CoolDownTimer(InitialName,cd/10)
				..()
			if(Owner.mana <= mana_cost)
				if(spam==0)
					Owner.NoMana()
					spam = 1
					spawn(20) spam = 0
		Skills
			icon = 'Ninjutsu.dmi'
			SkillType = "Int"
			Kawa
				icon_state = "Kawa"
				InitialName = "Kawa"
				mana_cost = 0
				cd = 30
				Initiate(mob/Owner)
					..()
					if(canuseskill==0) return
					if(canuseskill==1)
						canuseskill = 0
						spawn(cd) src.canuseskill = 1
					if(Owner.mana <= mana_cost) return
					Owner.Shoot("wave",Owner.getMouse())
			Shuriken
				icon_state = "Shuriken"
				InitialName = "Shuriken"
				cd = 20
				Initiate(mob/Owner)
					..()
					if(canuseskill==0) return
					if(canuseskill==1)
						canuseskill = 0
						spawn(cd) src.canuseskill = 1
					if(Owner.mana <= mana_cost) return
					Owner.Shoot("shuriken",Owner.getMouse())
			Vine
				icon_state = "Vine"
				InitialName = "Vine"
				mana_cost = 1
				cd = 150
				Initiate(mob/Owner)
					..()
					if(canuseskill==0) return
					if(canuseskill==1)
						canuseskill = 0
						spawn(cd) src.canuseskill = 1
					if(Owner.mana <= mana_cost) return
					Owner.Shoot("vine",Owner.getMouse())
			Endan
				icon_state = "Endan"
				InitialName = "Endan"
				Initiate(mob/Owner)
					..()
					if(canuseskill==0) return
					if(canuseskill==1)
						canuseskill = 0
						spawn(cd) src.canuseskill = 1
					if(Owner.mana <= mana_cost) return
					Owner.Shoot("fireball",Owner.getMouse())
					sleep(world.tick_lag+1)
			Shoot
				icon_state = "shoot"
				InitialName = "Shoot"
				mana_cost = 0
				cd = 150
				Initiate(mob/Owner)
					..()
					if(canuseskill==0) return
					if(canuseskill==1)
						canuseskill = 0
						spawn(cd) src.canuseskill = 1
					if(Owner.mana <= mana_cost) return
					Owner.Shoot("shoot",Owner.getMouse())
					sleep(world.tick_lag+1)
			Kunai
				icon_state = "Kunai"
				InitialName = "Kunai"
				cd = 20
				Initiate(mob/Owner)
					..()
					if(canuseskill==0) return
					if(canuseskill==1)
						canuseskill = 0
						spawn(cd) src.canuseskill = 1
					if(Owner.mana <= mana_cost) return
					Owner.Shoot("kunai",Owner.getMouse())
			Attack
				icon_state = "Attack"
				InitialName = "Attack"
				cd=  2
				mana_cost = 0
				Initiate(mob/Owner)
					..()
					if(canuseskill==0) return
					if(canuseskill==1)
						canuseskill = 0
						spawn(cd) src.canuseskill = 1
					for(var/mob/M in range(1,usr))
						if(get_dir(usr,M) == usr.dir)
							var/damage = 1
							M.damage(damage,M,"physical")
							M.knockback(48*2,-kget_angle(usr,M)+90,4*1)
			bar
				icon_state = "bar"
				InitialName = "bar"
				cd = 10000
				Initiate(mob/Owner)
					..()
					var/active = 0
					if(canuseskill==0) return
					if(canuseskill==1)
						canuseskill = 0
						spawn(cd) src.canuseskill = 1
					if(Owner.mana <= mana_cost) return
					usr.icon_state = "spin"
					active = 1
					spawn(1519) active = 0
					while(active==1)
						Owner.Shoot("bar",rand(0,360))
						sleep(world.tick_lag)
			Jump
				icon_state = "Jump"
				InitialName = "Jump"
				mana_cost = 0
				cd = 20
				Initiate(mob/Owner)
					..()
					if(canuseskill==0) return
					if(canuseskill==1)
						canuseskill = 0
						spawn(cd) src.canuseskill = 1
					usr.Jump()
			Run
				icon_state = "Run"
				InitialName = "Run"
				cd = 10
				mana_cost = 0
				Initiate(mob/Owner)
					..()
					if(canuseskill==0) return
					if(canuseskill==1)
						canuseskill = 0
						spawn(cd) src.canuseskill = 1
					usr.Run()
			Dash
				icon_state = "Dash"
				InitialName = "Dash"
				cd = 10
				mana_cost = 0
				Initiate(mob/Owner)
					..()
					if(canuseskill==0) return
					if(canuseskill==1)
						canuseskill = 0
						spawn(cd) src.canuseskill = 1
					usr.Dash()
			KageBunshin
				icon_state = "KageBunshin"
				InitialName = "KageBunshin"
				cd = 30
				mana_cost = 0
				Initiate(mob/Owner)
					..()
					if(canuseskill==0) return
					if(canuseskill==1)
						canuseskill = 0
						spawn(cd) src.canuseskill = 1
					usr.Shadowclone()