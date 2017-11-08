var
{
	g_iMapCounter = 3 // The map count is abituary and just gives us unique identifiers
	list/swapmap/g_listOfLoadedSwapMaps = list()
}
world
{
	New()
	{
		Proc_InitMaps()
		..()
	}
}
mob
{
	icon_state = "player"
	Login()
	{
		world << "The first two z levels (1 and 2) are the two physical .dmm files. You cannot delete them in this example but you can alter them."
		world << "\nYou are currently on z level 1"
		world << "\nMap names are incremental and continue to count up regardless of level count. You can be on level 3 with Map_7 if you delete enough times."
		world << "\nThe example randomly alters the color of one turf for each newly generated map to help tell the difference between maps."
		world << "\nWhen dynamically creating maps, the map is added to the first open slot. If you delete the map at z level 3 of 7 and then create a new map, it gets placed at z level 3. You can change that behavior but thats how it works in this example."
		src.loc = locate(1,1,1)
	}
	verb
	{
		ResetToGrass()
		{
			Proc_ResetToGrass(block(locate(1,1,z),locate(10,10,z)))
		}
		RandomizeMap()
		{
			Proc_RandomizeMap(block(locate(1,1,z),locate(10,10,z)))
		}
		MoveToZLevel()
		{
			Mob_MoveToZLevel()
		}
		CreateNewMapFromTemplate()
		{
			Mob_CreateNewMapFromTemplate()
		}
		DeleteMapInstance()
		{
			Mob_DeleteMapInstance()
		}
	}
	proc
	{
		//
		// Lets you bounce around the maps
		//
		Mob_MoveToZLevel()
		{
			src.loc = locate(1,1,text2num(input("Provide z level.","Z Level",z)))
			world << "You are at z level: [src.z]"
		}
		//
		// Lets you delete a map instance
		// You cannot delete the first two maps on z1 and z2 because those are not swapmaps. Those are real maps.
		//
		Mob_DeleteMapInstance()
		{
			var/sMapName = input("Select a map to delete!","","") in Proc_GetListOfLoadedSwapMapIDs()
			var/swapmap/m = SwapMaps_Find(sMapName)

			if(!m)
			{
				alert("Map does not exist! - [sMapName]")
				return
			}

			g_listOfLoadedSwapMaps.Remove(m) // Remove the map from our list
			world << "Deleting [m.id]!"
			m.Del() // Don't unload because we want to delete without saving.
		}
		//
		// We make a second call to a more generic proc for creating the template
		// and then move the player to the newly created map.
		//
		Mob_CreateNewMapFromTemplate()
		{
			var/swapmap/m = Proc_CreateNewMapFromTemplate()
			var/turf/Areaofhouse/S = new(src.loc)
			S.storedz = m.z1
			var/turf/Areaofhouse/X = new(locate(src.x,src.y,m.z1))
			X.storedz = usr.z
			world << "\nClone Created! You are now at z level: [z] and map: [m.id]"
		}
	}
}
atom
{
	icon = 'icon.dmi'
}
turf
{
	grass
	{
		icon_state = "grass"
	}
	dirt
	{
		icon_state = "dirt"
	}
}
proc
{
	//
	// Returns a list of map ids
	//
	Proc_GetListOfLoadedSwapMapIDs()
	{
		var/list/listOfSwapMapIDs = list()

		for(var/swapmap/m in g_listOfLoadedSwapMaps)
		{
			listOfSwapMapIDs.Add(m.id)
		}

		return listOfSwapMapIDs
	}
	//
	// Key function that will copy an existing template as a new map.
	//
	Proc_CreateNewMapFromTemplate()
	{
		var/swapmap/m = SwapMaps_CreateFromTemplate(input("Select a map template!","Map Selection","DesertComplex") in list("DesertComplex","JungleComplex"))
		m.SetID("Map_[g_iMapCounter++]")
		Proc_ApplyRandomTint(m.z1)
		g_listOfLoadedSwapMaps.Add(m)
		return m // So we can move the user there
	}
	//
	// Key function which takes your current .dmm file and turns it into a template. This is cool
	// because you can modify your .dmm (maps) without worrying about recreating your templates. It
	// just does it automatically on reboot.
	//
	Proc_InitMaps()
	{
		var/swapmap/m = new("DesertComplex", locate(1,1,1), locate(10,10,1)) // Create a swapmap from our default .dmm file so we don't have to manuall save this one to use as a template for all others.
		m.Save("Maps\\DesertComplex") // Saves all changes made on the map since the last time we edited it.
		m.Unload("DesertComplex") // Clean up.

		var/swapmap/m2 = new("JungleComplex", locate(1,1,2), locate(10,10,2)) // Create a swapmap from our default .dmm file so we don't have to manuall save this one to use as a template for all others.
		m2.Save("Maps\\JungleComplex") // Saves all changes made on the map since the last time we edited it.
		m2.Unload("JungleComplex") // Clean up.

		// If we had more maps, we would init them in the same manner
	}
	//
	// Turn the current map into all grass
	//
	Proc_ResetToGrass(var/listOfTurfsInView)
	{
		for (var/turf/t in listOfTurfsInView)
		{
			t.icon_state = "grass"
		}
	}
	//
	// Randomize the map so we can tell we've been there
	//
	Proc_RandomizeMap(var/listOfTurfsInView)
	{
		for (var/turf/t in listOfTurfsInView)
		{
			if (pick(0,1))
			{
				t.icon_state = "grass"
			}
			else
			{
				t.icon_state = "dirt"
			}
		}
	}
	//
	// Applies a random tint to one turf to help tell the difference between levels
	//
	Proc_ApplyRandomTint(var/z)
	{
		var/turf/t = pick(locate(rand(1,10),rand(1,10),z))

		if(pick(0,1))
		{
			t.icon -= rgb(rand(0,255),rand(0,255),rand(0,255))
		}
		else
		{
			t.icon += rgb(rand(0,255),rand(0,255),rand(0,255))
		}
	}
}