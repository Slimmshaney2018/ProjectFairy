client
	var
		fullscreen = 0	//Keep track of whether window is in fullscreen mode or not.
	New() //When a new client arrives (a new user logs in)...
		..() //Perform the default new client proc
		ToggleFullscreen() //Then toggle fullscreen to TRUE
	verb //Verbs can be accessed by the macros (using key presses), so we need to define verbs (not procs) for our key presses.
		ToggleFullscreen()
			fullscreen = !fullscreen //Toggle the fullscreen variable
			if(fullscreen) //If fullscreen == 1 (TRUE)
				winset(src, "default", "is-maximized=false;can-resize=false;titlebar=false;menu=") //Reset to not maximized and turn off titlebar.
				winset(src, "default", "is-maximized=true") //Now set to maximized. We have to do this separately, so that the taskbar is appropriately covered.
			else //If fullscreen == 0 (FALSE)
				winset(src, "default", "is-maximized=false;can-resize=true;titlebar=true;menu=menu") //Set window to normal size.