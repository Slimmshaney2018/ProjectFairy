//#define ii icon
//#define is icon_state
world
	fps = 40
	icon_size = 32
	view = "37x21"
mob
	icon = 'humanbase.dmi'
obj
{
	cpu_display
	{
		screen_loc = "NORTH:12, WEST:4"
		plane = 10
		maptext_width = 256
		New()
		{
			..()
			spawn(1)
				while(src)
					maptext = "<font style=\"font-family:monospace;\" color=red size=6>CPU: [world.cpu]%</font>"
					sleep(10)
		}
	}
}

/*mob/verb/Test141(mob/M)
//	animate(M, color = "blue" , time = 2, easing=SINE_EASING) // mudar core
//	spawn(4) animate(M, color = null, time = 3)
//	filters += filter(type="drop_shadow", x=0, y=0,size=5, offset=3, color=rgb(255,236,38))  // brilhar em volta
	animate(usr,alpha=0,time=2,loop=-1,easing=SINE_EASING)*/
mob
	verb
		SetInt(N as num)
			usr.int = N
		SetWave(W as num)
			usr.wave = W
/*mob
	Stat()
		statpanel("Inventory")	//MAkes a new stat panel called inventory

		stat(contents)	//this is where the contents will go
*/
/*
obj/follower
  var/max_range = 1000
  var/min_range = 0
  icon = 'fir.dmi'
  var/speed = 0.1
  var/mob/target
  New(var/atom/loc, var/mob/target)
    ..()
    src.target = target
    // use spawn() so that the procedure creating us isn't forced to wait for us to finish following
    spawn() src.follow()

  proc
    follow()
      while(get_dist(src, src.target) <= max_range)
        step_to(src, src.target, min_range)
        sleep(speed)
      // We've exited the loop, which means we are beyond our max range, so delete ourself
      del(src)

mob/verb/create_follower()
  var/S = new/obj/follower(src.loc, src)
  client.eye = S*/