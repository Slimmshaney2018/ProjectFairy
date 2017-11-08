/*
	Gap-Nudge Movement

	Includes:
	movement.dm
	movement_macros.dms

	A BYOND library
	By Tyruswoo
	July 18, 2017
	Originally written for BYOND v.5

	This little library enhances movement by allowing the player's mob to detect nearby gaps
	in the direction the player is trying to move, and then nudges the player's mob towards the gap.

	To test this out, login and try to move through small gaps in walls or around corners.
	Your mob will be able to find any nearby gaps through which to move.
*/
atom
	movable
		step_size = 3
client
	var
		diagonal_nudge = FALSE	//FALSE to nudge by mob.step_size on diagonal collisions (fast slide along walls). TRUE to nudge by nudge_size (slow slide).
		f = 0.1					//Min 0 to Max 1. Fraction of player's bound_width or bound_height to look for a gap.
		nudge_size = 1			//Number of pixels to nudge player's mob when finding a gap towards which to move. (Increasing above 1 may cause bugs on narrow gaps.)
		north = 0				//Keep track of movement key presses. See also movement_macros.dms.
		east = 0
		south = 0
		west = 0
	North()	//Player is trying to go northward.
		north = 1					//North was activated. Keep track of this.
		if(east) Northeast()		//If east is also activated, then move Northeast.
		else if(west) Northwest()	//Else if west is also activated, then move Northwest.
	East()
		east = 1
		if(north) Northeast()
		else if(south) Southeast()

	South()
		south = 1
		if(east) Southeast()
		else if(west) Southwest()

	West()
		west = 1
		if(north) Northwest()
		else if(south) Southwest()

	Northeast()
		if(diagonal_nudge)
			if(!(..() || Nudge(NORTHEAST, 0, nudge_size) || Nudge(NORTHEAST, nudge_size, 0))) ..()
		else
			if(!(..() || Nudge(NORTHEAST, 0, mob.step_size) || Nudge(NORTHEAST, mob.step_size, 0))) ..()
	Northwest()
		if(diagonal_nudge)
			if(!(..() || Nudge(NORTHWEST, 0, nudge_size) || Nudge(NORTHWEST, -nudge_size, 0))) ..()
		else
			if(!(..() || Nudge(NORTHWEST, 0, mob.step_size) || Nudge(NORTHWEST, -mob.step_size, 0))) ..()
	Southeast()
		if(diagonal_nudge)
			if(!(..() || Nudge(SOUTHEAST, 0, -nudge_size) || Nudge(SOUTHEAST, nudge_size, 0))) ..()
		else
			if(!(..() || Nudge(SOUTHEAST, 0, -mob.step_size) || Nudge(SOUTHEAST, mob.step_size, 0))) ..()
	Southwest()
		if(diagonal_nudge)
			if(!(..() || Nudge(SOUTHWEST, 0, -nudge_size) || Nudge(SOUTHWEST, -nudge_size, 0))) ..()
		else
			if(!(..() || Nudge(SOUTHWEST, 0, -mob.step_size) || Nudge(SOUTHWEST, -mob.step_size, 0))) ..()
	verb
		NorthReleased()
			set hidden = 1
			north = 0
		EastReleased()
			set hidden = 1
			east = 0
		SouthReleased()
			set hidden = 1
			south = 0
		WestReleased()
			set hidden = 1
			west = 0
	proc
		Nudge(d=0, x=0, y=0) //d is direction to face while being nudged. x and y are amounts to nudge, in pixels.
			return mob.Move(mob.loc, d, mob.step_x+x, mob.step_y+y)
		FindGap(d) //d is direction player is facing.
			switch(d)
				if(NORTH)
					if(DensityCount(f,1,-f,-1,0,0,0,1) == 0) return EAST
					else if(DensityCount(0,1,-f,-1,0,0,0,1) == 0) return WEST
				if(EAST)
					if(DensityCount(1,f,-1,-f,0,0,1,0) == 0) return NORTH
					else if(DensityCount(1,0,-1,-f,0,0,1,0) == 0) return SOUTH
				if(SOUTH)
					if(DensityCount(f,0,-f,-1,0,-1,0,1) == 0) return EAST
					else if(DensityCount(0,0,-f,-1,0,-1,0,1) == 0) return WEST
				if(WEST)
					if(DensityCount(0,f,-1,-f,-1,0,1,0) == 0) return NORTH
					else if(DensityCount(0,0,-1,-f,-1,0,1,0) == 0) return SOUTH
		DensityCount(fx,fy,fw=0,fh=0,dx=0,dy=0,dw=0,dh=0) //Fractions used to find offset_x, offset_y, extra_width, & extra_height for obounds proc. Plus dx,dy,dw,dh offsets.
			var/c = -1 //Counts the number of dense atoms found.  -1 if no atoms found (i.e. the search was at the map's edge).
			for(var/atom/A in obounds(mob, mob.bound_width*fx+dx, mob.bound_height*fy+dy, mob.bound_width*fw+dw, mob.bound_height*fh+dh))
				if(c < 0) c = 0		  //Found the first atom.
				if(A.density) c += 1  //Found a dense atom.
			return c  //Return number of dense atoms found, or -1 if there were no atoms found (i.e. the search was at the map's edge).