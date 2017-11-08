
mob
	var/mob/currentTarget = null
	var/image/target = null
	var/autoTarget = 0

	proc
		startTargeting()
			autoTarget = 1

		stopTargeting()
			autoTarget = 0
			currentTarget = null
			del(target)

		updateTarget()
			if(autoTarget)
				currentTarget = locate(/mob) in oview(src)
				if(currentTarget) paintTarget()

		updateTargetsForOthers()
			for(var/mob/M in oview())
				M.updateTarget()

		paintTarget()
			if(target != null) del(target)
			target = image('Icons.dmi',currentTarget,"Target",)
			src << target

		relocate()
			// Remember what is seen
			var/list/lastSeen = new/list()
			for(var/mob/M in oview(src))
				lastSeen += M

			// Remove from the location
			loc = null

			// Update targets for last seen mobiles
			for(var/mob/M in lastSeen)
				M.updateTarget()

	Move()
		..()
		updateTarget()
		updateTargetsForOthers()

	Del()
		relocate()
		..()

