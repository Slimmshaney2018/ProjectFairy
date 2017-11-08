mob/var/tmp/maptext/level_up
	_levelUp
	background/_levelUp_bg
mob/var/tmp/maptext/skill_use/_skillUse

maptext
	parent_type = /obj
	icon = null
	layer = FLY_LAYER+1
	mouse_opacity = 0
	alpha = 0
	var created

	skill_use
		maptext_height = 133
		maptext_width = 256
		screen_loc = "27:25,1:5"
		proc
			_update(_txt,client/c)
				if(c)
					alpha=0
					c.screen += src
					animate(src,maptext = "[_txt]",alpha=255,time=4, easing = SINE_EASING|EASE_OUT)
					var t = world.time
					created = t
					spawn(30)
						if(created == t)
							animate(src,alpha=0,time=4)
							spawn(4)
								c.screen-= src
								maptext=null
								src = null
maptext
	level_up
		maptext_height = 100
		maptext_width = 500
		screen_loc = "10:21,17"
		layer = FLY_LAYER+2
		background
			screen_loc = "10:21,17:20"
			layer =FLY_LAYER+1
			blend_mode = BLEND_MULTIPLY
			icon = 'levelup_bg.dmi'
		proc
			_update(_txt,client/c)
				if(c)
					var/formatting = "<style>body {font-family: 'Trajan Pro'; font-size: 4;}</style>"
					_txt = formatting + "<center>[_txt]</center>"
					alpha=0
					c.screen += src
					animate(src,maptext = "[_txt]",alpha=255,time=6, easing = SINE_EASING|EASE_OUT)
					var t = world.time
					created = t
					spawn(30)
						if(created == t)
							animate(src,alpha=0,time=4)
							spawn(4)
								c.screen-= src
								maptext=null
			_BG_update(client/c)
				if(c)
					alpha=0
					c.screen += src
					animate(src,alpha=200,time=4, easing = SINE_EASING|EASE_OUT)
					var t = world.time
					created = t
					spawn(30)
						if(created == t)
							animate(src,alpha=0,time=4)
							spawn(4)
								c.screen-= src



proc

	outOfMana_notification()
		return "<center><b><font color=Blue><font size=4>Not enough Mana!</b></center></font>"
	outOfStamina_notification()
		return "<center><b><font color=Yellow><font size=4>Not enough stamina!</b></center></font>"
mob/proc
	LevelUp_notification(_skill,client)
		if(!_skill) CRASH("No skill sent through level up notification; proc halted.")
		if(!_levelUp_bg) _levelUp_bg = new()
		if(!_levelUp) _levelUp = new()
		_levelUp._update(call(src,"levelUpNotification")(_skill),client)
		_levelUp_bg._BG_update(client)
		//play a sound
		//display level too

	levelUpNotification(_skill)
		if(_skill == "level") return "Your level has increased."
		else return "Your [_skill] skill has increased."

mob/proc
	LevelUP_notification()
		if(!_levelUp_bg) _levelUp_bg = new()
		if(!_levelUp) _levelUp = new()
		_levelUp._update(call(src,"LevelUPMessage")(),client)
		_levelUp_bg._BG_update(client)
	LevelUPMessage()
		return "<font color=white><b>Level-UP!</b></font>"
/*mob/proc
	Teamo_notification()
		if(!_levelUp_bg) _levelUp_bg = new()
		if(!_levelUp) _levelUp = new()
		_levelUp._update(call(src,"Teamootification")(),client)
		_levelUp_bg._BG_update(client)
	Teamootification()
		return "<font color=white><b>Ataos:Hi mimao,we're the best</b></font>"*/
//mob/verb/Iai()
//	Teamo_notification()
mob/proc
	NoMana()
		if(!_skillUse) _skillUse = new()
		_skillUse._update(outOfMana_notification(),client)