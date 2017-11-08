

//Want to customize the way the tree loads? Change CURRENT_SCHEME
//to one of the below methods
//You WILL have to be careful with your layout, if you choose to use arrows

//PS: Arrows do not currently work.

#define CURRENT_SCHEME LEFT_TO_RIGHT

#define BOTTOM_TO_TOP "skilltree:[posy-1],[posx-1]"
#define TOP_TO_BOTTOM "skilltree:[proto.layout.len-posy],[li.len-posx]"
#define LEFT_TO_RIGHT "skilltree:[posx-1],[posy-1]"
#define RIGHT_TO_LEFT "skilltree:[li.len-posx],[proto.layout.len-posy]"

mob/var

	class="runeknight"			 //semi-necessary for it to work
								 //this can be either "runeknight" or "magician"
	skillpoints=10
	list/skills=list()	 // skill=level

	skilltree
		magician/mag =new	 //skilltree objects necessary to generate the HUD
		runeknight/rk=new

	tmp/busy = FALSE

mob/Stat()
	..()
	for(var/skill/o in skills)
		stat("[o]  [skills[o]]")

				//just some demonstrative stuff
mob/verb
	Skillpoints_Set()
		skillpoints=input(src,"How many skillpoints?","Skillpoints")as num


client/New()
	..()
	load_tree(mob.class)

client/proc
	load_tree(t)
		var/skilltree/proto
		switch(t)
									//gotta be a better way of doing this..
			if("magician")  proto=mob.mag
			if("runeknight")proto=mob.rk

		for(var/posy=1 to proto.layout.len)
									//y value
			var/list/li=proto.layout[posy]

			for(var/posx=1 to li.len)
									//x value
				if(li[posx])
									//don't want to spam null errors
					var/skill/s=li[posx]
					if(istype(s,/skill/arrow))
						screen += new s
						return

					var/skill/ns=new s("[CURRENT_SCHEME]")

					/*
					var/skill/ns=new s("skilltree:[li.len-posx],[proto.layout.len-posy]")
						This will make it go from right to left

					var/skill/ns=new s("skilltree:[proto.layout.len-posy],[li.len-posx]")
						This will make it go from top to bottom

					var/skill/ns=new s("skilltree:[posx-1],[posy-1]")
						This will make it go from left to right

					var/skill/ns=new s("skilltree:[posy-1],[posx-1]")
						This will make it go from bottom to top
					*/

					screen += ns
									//thank you, lummox's demo - I like the idea of overriding new() for this purpose
					if(!(locate(ns.type) in mob.skills))
									//you haven't learned me yet
						if(ns.reqskill)
									//do we require a skill?
							if(!(locate(ns.reqskill) in mob.skills))
									//we don't have the required skill.. sadface
								ns.overlays += new/skill/unbuyable

							else
								var/tskill=locate(ns.reqskill) in mob.skills
								if(tskill)

									if(mob.skills[tskill]<ns.reqskilllvl)
									//you can't buy it if it has a level requirement and your level isn't high enough.
										ns.overlays += new/skill/unbuyable

									else

										ns.overlays += new/skill/available

								else
									//this should never occur.
									world << "Oddity here"

						else

							ns.overlays += new/skill/available

					else
									//verification that it exists
						var/tskill=locate(ns.type) in mob.skills
						if(tskill)

							ns.curlevel=mob.skills[tskill]
									//we want to show it's a maxxed out skill!
							if(ns.curlevel>=ns.maxlevel)

								ns.overlays+=new/skill/completed