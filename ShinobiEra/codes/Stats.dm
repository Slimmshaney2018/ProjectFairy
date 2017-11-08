/*
Rather than saving the job datum, I can save the job datum's id.
And the job class can regenerate all relevant information deterministically.
So I can retweak stats on the fly without actually giving a shit about what's in the savefile.
It reduces complexity of the database/storage space.
Increases flexibility, reduces bugs.
Eliminates the need for wiping.
(Not your ass tho, bc gross)
So to know all of a player's stats, all I need to know are:

Race (and therefore racial attributes/talents)
Class
Level
Talent investments
Equipment
Ongoing persistent effects.*/

//contents will save on its own.
mob/var
	hp=10
	mp=10
	str=1
	str_max=500
	agi=1
	vit=1
	int=1
	luk=1
	level = 1
	levelcap = 100
	maxexp=1000000
job
	var
		id
		list/skills
//		list/base_stats = list("hp"=10",""mp"=10",""str"=1",""agi"=1",""vit"=1",""int"=1",""luk"=1")
		list/base_stats = list(hp=10)
//		list/bonus_stats = list("hp"=999",""mp"=99",""str"=60",""agi"=60",""vit"=60",""int"=60",""luk"=60")
		list/bonus_stats = list(hp=999)
	proc
		Level(mob/m,new_level)
			var/lv, old_level = m.level, sl = m.skills
			var/LEVEL_CAP = m.levelcap
			for(var/v in skills)
				lv = skills[v]
				if(lv>old_level)
					sl += v
					if(lv>new_level)
						break
			lv = (new_level/LEVEL_CAP)
			lv = (lv**2 + lv)/2
			for(var/v in base_stats)
				m.base_stats[v] = base_stats[v] + round(bonus_stats[v] * lv)
/*
	New()//That looks through the global skills list and converts the id references to references to the global singleton skill objects.
		var/list/l = skills, list/sl = (skills = list())
		for(var/v in l)
			sl[global.skills[v]] = l[v]//Global=Every skill in the game, yes.
		..()
*/

/*
base_stats is the starting stats at level 1 of that class.
bonus_stats is the stats that are added to the base stats according to the progression curve:

frac = new_level/LEVEL_CAP
(frac*frac + frac)/2
new_level/LEVEL_CAP returns a value between 0 and 1
ergo multiplying frac * frac results in a value between 0 and 1
and adding frac to that results in a value between 0 and 2.
dividing by 2 again normalizes the value to within 0 and 1
frac * frac is an expoential curve.
frac is a linear curve.
(frac * frac + frac)/2 is an exponential curve modulated by a linear curve.(editado)
http://www.byond.com/forum/?post=1239761
NOVAS MENSAGENS
TerXIII - Hoje às 01:17
I talk about those curves in this post.
*/