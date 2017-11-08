/*
turf
	icon = 'turf.dmi'

	New()
		..()
		icon_state = pick("red","yellow","blue","green","orange","violet","black","white")
*/
//client
//	command_text = "chat-say \""
// chatbox settings
chatbox
	screen_loc = "1:19,4:17"

	maptext_height = 190
	maptext_width = 250

	maxlines = 150
	chatlines = 9

	font_family = "Times New Roman"
	font_color = "#FFFFFF"
	text_shadow = "#222d"

chatbox_gui
	icon = 'chatbox_gui.dmi'

	background
		icon = 'chatbox_bg.dmi'
		screen_loc = "1:14,9:14 to 8:15,4"
		mouse_opacity = 0

	start
		icon_state = "start"
		screen_loc = "9:16,9"

	up
		icon_state = "up"
		screen_loc = "9:16,8:16"

	down
		icon_state = "down"
		screen_loc = "9:16,6"

	end
		icon_state = "end"
		screen_loc = "9:16,5:16"


// implementation

mob

	// chatbox creation

	Login()
		..()
		spawn(2)
			if(client)
				client.chatbox_build() // build the chatbox
				client.chatlog = "outputwindow.output" // set chatlog
				client.chatlog_record("\b\[ This is your chatlog ]") // enter a text into your chatlog
				newocc(world, "[name] has logged in.", "yellow") // notify world

/*	verb

	// chat examples

		chat_pm(mob/mob as mob, txt as text)

			if(istype(mob))
				newocc(src, "\[to: [mob.name]\] [txt]", "#ffa000")
				newocc(mob, "\[from: [name]\] [txt]", "#ffa000")

//		chat_say(txt as text)
//			newocc(view(src,6), "[name]: [txt]")

		chat_world(txt as text)
			newocc(world, "[name]: [txt]", rgb(50,250,100))

//		chat_colored(txt as text,color as color)
//			chat_say(_ftext(txt,color))


	// chatbox

		clear_chatbox()
			set category = "chatbox"
			if(client)
				client.chatbox_clear()

		hide_chatbox()
			set category = "chatbox"
			if(client)
				client.chatbox_show(0)

		show_chatbox()
			set category = "chatbox"
			if(client)
				client.chatbox_show()
*/