//I added alot of whitespace so it's easier to read, sorry if that bothers you.
mob
	icon = 'Icons.dmi'
	icon_state = "Player"

	var
		swapmap/map	  //Creates a variable that is a swapmaps map
		Savedx	  //Is used later to record the players X position
		Savedy	  //Is used later to record the players Y position
		Savedz	  //Is used later to record the players Z position
		location	//Is used later on to see who is on who's map

	Login()
		..()
		src.map = SwapMaps_Find("house_[src.ckey]")	 //At login we check to see if there is a map already made for our player
		if(map) SwapMaps_Load("house_[src.ckey]")	//If there is a map we load it

	Logout()
		map = SwapMaps_Find("house_[src.ckey]")	  //At logout we check to see if the player has a map

		if(map)	  //If a map is located
			var/flag = 0	//This is going to be used later to see if there are any turfects on the map

			for(var/turf/T in block(map.LoCorner(), map.HiCorner()))	//This checks the map for any turfs
				if(locate(/atom/movable ) in T)
					flag = 1	//If there are any turfects on the map then it sets our variable flag to 1
					break
			for(var/mob/M in world)	//This checks all the mobs in the world
				if(M.client && M.location == "[src]'s house")	  //If the mob is a player and their location is the house
					M.loc = locate(M.Savedx,M.Savedy,M.Savedz)	  //They get teleported out of the house

			if(flag)
				map.Unload()	//if there was an turfect found we save the map.

		for(var/turf/House/H in world)	 //We check all the houses in the world
			if(H.owner == src)	 //If one belongs to the player
				new/turf/Grass(locate(H.x,H.y,H.z))	  //We create a turf of grass over the old house

		del(src)

	verb
		Claim_Land()
			if(locate(/turf/House) in oview(0))
				src << "You cannot claim land here."
				return	//If there is already a house at your location it doesnt let you build there

			src.map = SwapMaps_Find("house_[src.ckey]")	  //We check to see if there is a map already made

			if(src.map)	  //If a map is found...
				src.Savedx = src.x	  //We save the players X position into a variable
				src.Savedy = src.y	  //We save the players Y position into a variable
				src.Savedz = src.z	  //We save the players Z position into a variable

				var/turf/House/Po = new/turf/House(src.loc)	  //We place the house turf at the players location
				Po.owner = src	  //Set the house's owner to the player
				Po.name = "[src]'s House"	//Change the houses name so everyone knows who it belongs to

				src.loc = locate(src.map.x1+30,src.map.y1+1,src.map.z1)	  //We teleport the player to the house
				src.verbs -= /mob/verb/Claim_Land	//Lastly we get rid of this verb
				src.location = "[src]'s house"

			else	//If no map is found..
				src.Savedx = src.x	  //We save the players X position into a variable
				src.Savedy = src.y	  //We save the players Y position into a variable
				src.Savedz = src.z	  //We save the players Z position into a variable

				var/turf/House/Po = new/turf/House(src.loc)	  //We place the house turf at the players location
				Po.owner = src	  //Set the house's owner to the player
				Po.name = "[src]'s House"	//Change the houses name so everyone knows who it belongs to

				src.map = new("house_[src.ckey]",60,60,3)	//If there isn't a map we create a new one that is 60x60 tiles

				map.BuildFilledRectangle(locate(map.x1+26,map.y1+1,map.z1),\
				                         locate(map.x1+38,map.y1+15,map.z1),\
				                         /turf/Tile)	//We build a filled rectangle from 26,1 to 38,15

				map.BuildRectangle(locate(map.x1+25,map.y1,map.z1),\
				                   locate(map.x1+39,map.y1+14,map.z1),\
				                   /turf/Wall)	  //We build a rectangle from 25,0 to 39,14
				new/turf/Ladder(locate(map.x1+32,map.y1+7,map.z1))

				src.loc = locate(map.x1+32,map.y1+6,map.z1)
//				src.verbs -= /mob/verb/Claim_Land
				src.location = "[src]'s house"
turf
	icon = 'Icons.dmi'

	House
		var/mob/owner	//Make a mob variable for later use
		icon_state = "House"

		Entered(mob/M)
			if(ismob(M) && M.client)	//If a mob entered the House and is a player
				M.Savedx = M.x	  //We save M's X position into a variable
				M.Savedy = M.y	  //We save M's Y position into a variable
				M.Savedz = M.z	  //We save M's Z position into a variable
				var/swapmap/SM = SwapMaps_Load("house_[owner.ckey]")	//We make a variable equal the house's map
				M.loc = locate(SM.x1+32,SM.y1+6,SM.z1)   //We teleport M to the house
				M.location = "[src.owner]'s house"
	Grass
		icon_state = "Grass"

	Tile
		icon_state = "Tile"

	Wall
		icon_state = "Wall"
		density = 1

	Ladder
		icon_state = "Ladder"

		Entered(mob/M)
			if(ismob(M) && M.client)	//If a mon entered the ladder and is a player
				M.loc = locate(M.Savedx,M.Savedy,M.Savedz)	 //We teleport them to their saved location
				M.location = null
	dense
		density = 1
		//This is used so players cannot run off the map if the swapmaps map is bigger than
		//the other maps