mob/proc
	Attack(mob/M as mob in orange(1))
		var/damage = usr.str-M.def
		M.hp -= damage
		F_damage(M, damage, "#ff0000")
		M.knockback(48*(usr.str-M.def),-kget_angle(src,M)+90,4*(usr.str-M.def))
mob
	verb/selfko()
		src.knockback(48*(100),-kget_angle(src,src)+90,4*(9))
/*
mob/verb/Cage()
	SquareFilled()
mob/verb/Line()
	var/list/l = usr.loc:get_line(8,usr.dir)
	for(var/turf/t in l)
		var/obj/cage/C=new(t)
		C.dir = usr.dir
		sleep(1)
*/
/*

mob/proc
	Damage(N as num, T as text, M as mob)//N is the amount of damage recieved, T the type, M the attacker
		//This will also allow you to check the type of attack here, using whatever means you so choose, to determain what type of modifier to add to the damage
		//ie: N=max(1,N+(M.stat-=src.statDef))
		N=min(hp,N)//set N to be either the current HP or the damage amount, depending on whatever is smaller, allowing you to hopefully never go under 0 hp.
		hp-=N//remove N from src's hp
		src<<"[M] hit you for [N], by using their [T]."//Tell the src what's happening
		DeathCheck(T,M)//Kill src/check for hp
	DeathCheck(T as text, M as mob)//T is the type of damage recieved, M is the one who caused the damage.
		if(hp) return//if src has hp still, cancel the death
		switch(T)//switch the type
			if("Taijutsu")//if the type is tai, increase tai
				M.taijutsu++
			if("Genjutsu")//if the type is gen, increase gen
				M.genjutsu++
			...//You get the idea here, I would hope.

mob/verb
	NinAttack(M as mob)//just to demo out what I've shown you, three different kinds of attacks showing the three different types.
		M.Damage(10,"Ninjutsu",src)
	GenAttack(M as mob)
		M.Damage(10,"Genjutsu",src)
	TaiAttack(M as mob)
		M.Damage(10,"Taijutsu",src)
*/