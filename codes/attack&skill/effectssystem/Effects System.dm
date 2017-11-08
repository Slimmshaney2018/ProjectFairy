
atom/var/list/fm_effects_list

effect
	var
		atom/owner      // The object that the effect is effecting.
		effects         // A set of params used to determine which vars to modify.
		replace         // A set of params containing effect types to replace.
		lifetime = 10    // Length in cycles that the effect exists.
		cycle_time = 10 // Number of ticks between each cycle.


	New(atom/new_owner, life=src.lifetime)
		// Make sure an owner exists to assign the effect to.
		// If no owner was specified, crash the proc.
		if(!new_owner)
			CRASH("Can not assign [src] to [new_owner].")
			return

		// The effect has no life, positive or negative, so it is ended immediately.
		if(!life)
			del(src)
			return

		// If an effect of this type was already found, increase the
		// lifetime of the existing effect instead of creating a new one.
		if(istype(new_owner.fm_effects_list, /list))
			for(var/effect/E in new_owner.fm_effects_list)
				if(E.type == src.type)
					E.lifetime += life

					// If the lifetime change was negative, and the lifetime of
					// the pre-existing effect is now equal or below 0, then
					// end the pre-existing effect's existance.
					if(E.lifetime <= 0)
						del(E)

					del(src)
					return

		// If the replace list is used, this searches the new owner's effects
		// list for any of the types to replace. If they exist, the type
		// to replace is removed.
		if(replace)
			var/params = params2list(replace)
			for(var/effect_type in params)
				for(var/effect/E in new_owner.fm_effects_list)
					if("[E.type]" == effect_type)
						del(E)

		// No pre-existing effect to remove life from, so just delete
		// the effect.
		if(life < 0)
			del(src)
			return

		// If the owner's fm_effects_list var is not currently a list(),
		// convert it into one.
		if(!istype(new_owner.fm_effects_list, /list))
			new_owner.fm_effects_list = list()

		// Setup the new effect.
		src.owner = new_owner
		src.lifetime = life
		owner.fm_effects_list += src

		// Activate the effect and begin its life countdown.
		src.Activate()
		spawn()
			Countdown()


	Del()
		// Countdown has run out or effect has been removed,
		// if it has an owner, deactivate the effect.
		if(owner)
			src.Deactivate()

			// Remove the effect from the owner's fm_effects_list
			owner.fm_effects_list -= src

			// If the owner no longer has any effects active,
			// change its fm_effects_list to null so that it doesn't
			// hog up an extra list() that isn't being used.
			if(!owner.fm_effects_list.len)
				owner.fm_effects_list = null
		..()


	// This converts the effects var params into a list of variables
	// to modify for the owner. It will only modify variables that
	// the owner has.
	proc/Activate()
		// Convert the effects params into a list of variables to modify.
		if(src.effects)
			var/params = params2list(src.effects)
			for(var/p in params)
				if(owner.vars.Find(p))
					owner.vars[p] += text2num(params[p])

		// The Start() proc is for modifying things beyond the
		// scope of the effects params.
		src.Start()
		return


	// This proc does just the opposite of what the Activate() proc does,
	// so that anything modified by the Activate() proc will be un-modified.
	proc/Deactivate()
		// Convert the effects params into a list of variables to modify.
		if(src.effects)
			var/params = params2list(src.effects)
			for(var/p in params)
				if(owner.vars.Find(p))
					owner.vars[p] -= text2num(params[p])

		// The Finish() proc is for un-modifying things beyond the
		// scope of the effects params.
		src.Finish()
		return


	// This is the proc that continuously counts the effect's lifetime
	// down until it runs out, then it deletes the effect. Each cycle
	// that the effect continues without ending, the Cycle() proc is called.
	proc/Countdown()
		// Loop the countdown infinitely while the effect exists.
		while(src)

			// Make sure the effect's cycle_time is at least 1, otherwise
			// it will cause an infinite loop and crash the program.
			if(src.cycle_time > 0)
				sleep(src.cycle_time)
			else
				sleep(1)

			src.lifetime--

			// If the lifetime for this effect has run out, delete the effect.
			// Otherwise, run the Cycle() proc.
			if(src.lifetime <= 0)
				del(src)
			else
				src.Cycle()


	// This proc is called when the effect is activated.
	proc/Start()
		return

	// This proc is called when the effect is deactivated.
	proc/Finish()
		return

	// This proc is called every second by the effect's heartbeat.
	proc/Cycle()
		return

