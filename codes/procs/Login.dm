mob/proc/sound1()
	src << sound('adventuring_song.ogg')
mob/Login()
	..()
//	src.toggle_daynight(1)
	src.loc=locate(null)
	client.WanderCam()
	src.getHud()
	spawn(10) src << sound('adventuring_song.ogg')
	client.screen += new /obj/cpu_display()
mob/Logout()
	src.saveprocess()
var/wandercams = list() //we're going to store every wandercam in the world here, because we know we'll need them infrequently later. This is a global variable.
//world/New()
//	world.loop_checks=0
mob/var/tmp/npc = 0
mob/wandercam
	invisibility = 1
	density = 0
	npc = 1
	New()
		..()
		wandercams += src //add this cam to the wandercams list
		walk_rand(src,world.tick_lag+0.1) //tell it to walk randomly every 1/10th of a second (0.1 (your original value) = 100 steps per second, which is insane)

	Del() //reference management is important to speed up deletion
		wandercams -= src
		walk(src,0)
		loc = null
		..()
client/proc
	WanderCam(duration=1#INF) //default duration is infinite
		set waitfor = 0
		var/next_cam = pick(wandercams), cur_cam, etime = world.time + duration
		perspective = EYE_PERSPECTIVE

		do //do whiles are a perfectly valid, if underutilized loop pattern. In this instance, they are actually ideal because their condition is being checked at the end of the loop rather than at the top.
			eye = next_cam //swap the current eye to the next one.
			cur_cam = eye
			sleep(min(600,etime-world.time))
			next_cam = pick(wandercams-cur_cam) //pick another eye to swap to after the specified time.
		while(eye==cur_cam && world.time<etime)

		if(world.time>=etime&&eye==cur_cam) //if the loop exited, and the wandercam routine wasn't interrupted by an eye swap.
			eye = mob
			perspective = MOB_PERSPECTIVE
mob
	proc/getHud()
		client.screen += new /obj/hud/Creationhud/newbutton()
		client.screen += new /obj/hud/Creationhud/loadbutton()
		client.screen += new /obj/hud/Creationhud/delbutton()
		client.screen += new /obj/hud/Creationhud/clockworkthing()
		client.screen += new /obj/hud/Creationhud/barthing()
	proc/removeHud()
		for(var/obj/hud/Creationhud/S in client.screen)
			animate(S,alpha = 0,pixel_y = 0,time = 6)
			spawn(6) del S
mob/var
	tmp/loginclick = 0
mob/proc/Create()
	if(loginclick==1) return
	src.loginclick = 1
	var/char_name
	while(!char_name)
		char_name = input("Please put your character name in here.","Name") as null|text
	src.name = char_name
	src.loc=locate(100,100,1)
	client.eye = src
	client.perspective = MOB_PERSPECTIVE
	src.removeHud()
	src.draw_nametag("[src.name]")
	src.client.StartHotkeys()
	src.saveprocess()
obj/hud
	Creationhud
		layer = FLOAT_LAYER+10
		barthing
			layer = FLOAT_LAYER+9
			icon = 'barthing.dmi'
			icon_state = ""
			screen_loc = "CENTER-8.9,CENTER-7.5"

			alpha = 0
			New()
				..()
				pixel_y = -8
				animate(src,alpha = 170,pixel_y = 0,time = 2)
//				animate(src,transform = matrix()*0.3, time = 1)
		clockworkthing
			icon = 'clockwork.dmi'
			icon_state = ""
			screen_loc = "CENTER-4,CENTER+8"
			alpha = 30
			New()
				..()
				pixel_y = -8
				animate(src,alpha = 120,pixel_y = 0,time = 2)
				animate(src,transform = matrix()*1.3, time = 15)
		newbutton
			icon = 'hudbuttons.dmi'
			icon_state = "new"
			screen_loc = "CENTER-2,CENTER+4"
			alpha = 0

			MouseEntered()
				icon_state = "newselect"
				animate(src,transform = matrix()*1.1, time = 3)
			MouseExited()
				icon_state = "new"
				animate(src,transform = matrix(), time = 3)
			New()
				..()
				pixel_y = -8
				animate(src,alpha = 200,pixel_y = 0,time = 6)
			Click()
				if(fexists("Saves/players/[usr.ckey].sav"))
					alert("You already have a savefile")
					return
				usr.Create()
		loadbutton
			icon = 'hudbuttons.dmi'
			icon_state = "load"
			screen_loc = "CENTER-2,CENTER"
			alpha = 0

			MouseEntered()
				icon_state = "loadselect"
				animate(src,transform = matrix()*1.1,time = 3)
			MouseExited()
				icon_state = "load"
				animate(src,transform = matrix(),time = 3)
			New()
				..()
				pixel_y = -8
				animate(src,alpha = 200,pixel_y = 0,time = 6)
			Click()
				if(usr.loginclick==1) return
				usr.loginclick = 1
				if(fexists("Saves/players/[usr.ckey].sav"))
					usr.loadprocess()
				else
					alert("You dont have a savefile")
					usr.loginclick = 0
					return
		delbutton
			icon = 'hudbuttons.dmi'
			icon_state = "del"
			screen_loc = "CENTER-2,CENTER-4"
			alpha = 0

			MouseEntered()
				icon_state = "delselect"
				animate(src,transform = matrix()*1.1,time = 3)
			MouseExited()
				icon_state = "del"
				animate(src,transform = matrix(),time = 3)
			New()
				..()
				pixel_y = -8
				animate(src,alpha = 200,pixel_y = 0,time = 6)
			Click()
				if(usr.loginclick==1) return
				usr.loginclick = 1
				if(fexists("Saves/players/[usr.ckey].sav"))
					switch(alert("Do you want to delete your savefile?",,"Yes","No"))
						if("Yes")
							fdel("Saves/players/[usr.ckey].sav")
							alert("Savefile deleted")
							usr.loginclick = 0
				else
					alert("You dont have a savefile")
					usr.loginclick = 0
					return