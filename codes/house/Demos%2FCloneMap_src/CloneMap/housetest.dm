turf
	Areaofhouse
		icon = 'icon.dmi'
		var/storedz
		Entered(mob/M)
			if(ismob(M) && M.client)
				M.loc = locate(1, 1, src.storedz)