obj
	hud/Clan
		delbutton
			icon = 'hudbuttons.dmi'
			icon_state = "del"
			screen_loc = "CENTER-1,CENTER-4"
			alpha = 0

			MouseEntered()
				icon_state = "delselect"
				animate(src,transform = matrix()*1.1,time = 3)
			MouseExited()
				icon_state = "del"
				animate(src,transform = matrix(),time = 3)