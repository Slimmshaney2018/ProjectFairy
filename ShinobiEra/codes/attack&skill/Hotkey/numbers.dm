/*obj
	proc
		Action()
	Skillcards/Skills
		icon='hud.dmi'
		screen_loc = "WEST,SOUTH"
		var/cdtime=0//set amount that will set cooldown
		Fire
			icon_state="fire"
			cdtime=10
			Action()
				.=..()
		Shield
			icon_state="shield"
			cdtime=5
			Action()
				.=..()
		Sword
			icon_state="sword"
			cdtime=5
			Action()
				.=..()
		Action()
			if(!usr.cooldownlist) usr.cooldownlist=new
			if(usr.cooldownlist[name]) return 0
			..()
			usr.CoolDownTimer(name,cdtime)
			return 1
*/
atom
	proc
		Counters(time,px,py)
			set waitfor = FALSE
			if(time>0)
				src.AddName2("[time]",px+3,py+46,1)
				sleep(10)
				time-=1
				Counters(time,px,py)
			else
				src.AddName2("",0,0,1)
mob
//	verb
//		Hud()
//			DisplayTechs()
/*		Countest(t as text)
			usr.CoolDownTimer(t,50)*/
	var
		list/techniques
		list/cooldownlist
/*	proc
		CoolDownTimer(word,time,silence=0,cut=0)
			set waitfor = FALSE
			if(!cooldownlist) cooldownlist=new
			var/obj/Skillcards/tech=techniques[word]
			cooldownlist[word]=time
			do
				if(cut==0)
					if(tech&&silence==0)
						tech.Counters(time,0,-16)
						tech.color="red"
						animate(tech,transform=null,alpha=255,color=null,time=time*10,easing=QUAD_EASING)
					cut=1
				cooldownlist[word]-=1
				sleep(10)
			while(cooldownlist[word]>0)
			cooldownlist-=word*/
	proc
		CoolDownTimer(word,time,silence=0,cut=0)
			set waitfor = FALSE
			if(!cooldownlist) cooldownlist=new
			var/obj/Skillcards/tech=techniques[word]
			cooldownlist[word]=time
			do
				if(cut==0)
					if(tech&&silence==0)
						tech.Counters(time,0,-16)
						tech.color="red"
						animate(tech,transform=null,alpha=255,color=null,time=time*10,easing=QUAD_EASING)
					cut=1
				cooldownlist[word]-=1
				sleep(10)
			while(cooldownlist[word]>0)
			cooldownlist-=word
		LearnTech(type)
			if(!techniques) techniques=new
			var/obj/Skillcards/T=new type
			techniques[T.name]=T
			src<<"You've learned [T.name]"
		DisplayTechs()
			for(var/v in typesof(/obj/Skillcards)-/obj/Skillcards)
				LearnTech(v)
			var/techpos=0
			for(var/tname in techniques)
				techpos++
				var/obj/Skillcards/T=techniques[tname]
				T.AddName("[techpos]",-8,12,0)
				client.screen += T
obj/Supplemental/NameDisplay
	icon='Alphabet.dmi'
	layer = MOB_LAYER+100
	pixel_y=-10
	alpha=255
obj/Supplemental/NameDisplay3
	alpha=255
	icon='Alphabet2.dmi'
	layer = MOB_LAYER+100




atom/proc/AddName(var/Name2Add,fx=0,fy=0,change=0)
	if(Name2Add==null) Name2Add=src.name
	var/letter=" "
	var/spot=0
	var/obj/NL=new/obj/Supplemental/NameDisplay
	if(change)
		src.overlays=null
		if(change==2)
			NL.plane=src.plane
			NL.appearance_flags=RESET_TRANSFORM
			NL.layer=MOB_LAYER+12
	var/px=fx
	while(letter!="")
		spot+=1
		letter=copytext(Name2Add,spot,spot+1)
		if(letter=="") continue
		px+=6
		if(px>=32*10||letter=="^")
			px=fx
			fy-=12
			if(letter=="^")
				letter=null
		var/obj/j=src
		NL.pixel_x=px+fx+9
		NL.pixel_y=fy-10
		NL.icon_state=letter
		if(j.screen_loc!=null)
			NL.layer=MOB_LAYER+12
		src.overlays+=NL
	del(NL)
atom
	var/tmp/list/Name2
	var/tmp/list/Name2perm
	proc/AddName2(var/Name2Add,fx=0,fy=0,change=0)
		if(Name2Add==null) Name2Add=src.name
		var/letter=" "
		var/spot=0
		var/obj/NL=Name2
		var/obj/NL2=Name2perm
		src.overlays-=NL2
		if(change==1)
			if(NL2) NL2.overlays=null
		if(!NL) NL=new/obj/Supplemental/NameDisplay3
		if(!NL2) NL2=new/obj/Supplemental/NameDisplay3
		var/px=fx
		while(letter!="")
			spot+=1
			letter=copytext(Name2Add,spot,spot+1)
			if(letter=="") continue
			px+=6
			if(px>=32*10||letter=="^")
				px=fx
				fy-=14
				if(letter=="^")
					letter=null
			var/obj/j=src
			NL.pixel_x=px+fx+9
			NL.pixel_y=fy-10
			NL.icon_state=letter
			if(j.screen_loc!=null)
				NL.layer=MOB_LAYER+12
			NL.name="NameDisplay2"
			NL2.overlays+=NL
		src.overlays+=NL2
		Name2perm=NL2
