
mob
	icon = 'Icons.dmi'
	icon_state = "Blue Circle"

	Login()
		Move(locate(25,25,1))
		usr << "<b>Auto Targeting Demo</b>"
		usr << "\nArrow keys to move."
		usr << "\nIf you're in a mob's view, they will tell you to pick a new target when they move."
		usr << "\nIf a mob is in your view, you will tell them to pick a new target when you move."
		usr << "\nIf a mob is deleted it will be moved to a null location using relocate() before it is deleted."
		usr << "\nIf a mob is teleported a call to relocate will need to be made before it moves."

	verb
		Start_Targeting()
			startTargeting()

		Stop_Targeting()
			stopTargeting()

client
	perspective = EDGE_PERSPECTIVE

world
	view = 9
