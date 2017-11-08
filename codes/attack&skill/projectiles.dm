atom/proc/spawndel(time)
	spawn(time)
		del src
mob
	var
		level
mob
	player
/*turf/Enter(obj/projectile/p)

	if(istype(p) && !p.hit_walls)
		return TRUE
	..()*/
//var/FFF = 'yutpixel.ttf'
atom/movable/proc/projectile_crossed()

ability
atom/movable/Cross(obj/projectile/p)
	if(istype(p))
		projectile_crossed(p)

		if(src in p.cant_collide)
			return TRUE

		if(p.only_cross && src != p.only_cross)
			return TRUE

		if(p.owner==src)
			p.hit_owner()
			return TRUE
		if(p.owner && ismob(src) && !p.owner:can_hurt(src))
			return TRUE

		if(!ismob(src) && !p.hit_walls)
			return TRUE

	return ..()
mob
	var/kills=0
	var/tmp/dead=0
	var/tmp/tombstone_loc = list(1,1,1)
	var/tmp/damaged=0
	proc

		Shoot(t,Angle,item/a)
//				if(istype(src,/mob/player) && src:dead)
//					return
			var/X = text2path("/obj/projectile/[t]")
			if(X)
				new X (src, Angle,null,null,a)

		can_hurt(mob/m)
			if(m)
//					if(m.rolling)
//						return 0
//					if(dojo() && m.dojo())
//						return 1

//					if(m.village == village)
//						return 0
//					if((m.level < 5 && m.client) || (level < 5 && client))
//						return 0

				return 1



		damage(damage,mob/m,dtype)
			if(src.npc==1) return
			if(istype(src,/mob/ShadowClone))
				del(src)
			if(!dead && m.can_hurt(src))
				var/damage_mult=1
				if(dtype == "physical")
					damage += m.str
					if(stone)
						damage_mult = 0
					if(m.weapon == "kunai" && m.kunais)
						damage += round(m.dex/2)
				if(dtype == "magic")
					damage += m.int
					if(stone)
						damage_mult = 0.3
				if(dtype == "weapon")
					damage += m.dex
				if(damage_mult)
					if(blazed)
						damage_mult = 1.5
				damaged = world.time+5
				hp -= (damage) * damage_mult
				F_damage(src, damage, "#ff0000")
				if(hp < 0)
					die(m)
				else
					animate(src,color = "red",time=2)
					animate(color=null,time=2)
//						hitstun = world.time+2
					flick("hurt",src)

		die(mob/M)
			if(wounds)
				wounds--
//					updateHud("wounds")
//					damage_number("KOed")
				KO()
				spawn(70)
					if(dead)
						get_up()
			else
				KO()
				spawn(50)
					if(dead && wounds==0)
						if(M)
//							if(dojo() && M.dojo())
							if(client)
								if(M)
									if(M.client)
										world << "[src] was killed by [M]"
//											M.gain_vp(level * 5)
//											var/X = M.rank_2()
//											M.kills++
//											if(M.rank_2() != X)
//												world << "[M] is now [M.rank_2()]!"
//											M.kill_streak++
//											if(M.kill_streak >=5)
//												world << "[M] is on a [M.kill_streak] kill streak!"
//									kill_streak = 0

/*									if(myArea())
									var/area/zones/A = myArea()
									if(A.belongs_to == village)
										A.progress -= level
										for(var/mob/player/M2 in A.my_players)
											M2.updateHud("area bar")*/

						dead()

		KO()
			maptext = null
			walk(src,null)
			dead=1
			var/matrix/M = matrix()
			M.Turn(pick(-90,90))
			M.Translate(0,-8)
			src.dir = NORTH
			animate(src,transform = M,easing = BOUNCE_EASING,time = 10)
			if(client)
				animate(client,color="red",time=10)
				animate(color=null,time=10)
				sight |= BLIND
				sight |= SEE_SELF

		get_up()
			if(client)
				sight &= ~BLIND
			dead=0
			transform = matrix()
			hp = max_hp
//				updateHud("hp bar")
//				update_overlays()

		dead()
//				if(level >= 20 && !dojo())
//					Permadeath=1
//					Save()
//					Load()
//				else
//				damage_number("dead")
			get_up()
			respawn()

		respawn()
			if(client)
//				if(!dojo())
				tombstone_loc[1] = x
				tombstone_loc[2] = y
				tombstone_loc[3] = z
				var/turf/T = locate(tombstone_loc[1],tombstone_loc[2],tombstone_loc[3])
				if(T)
					new/obj/tombstone(src)


				loc = locate(respawn_loc())
			else
				loc = origin_loc
			wounds = 2
//				updateHud("wounds")
		respawn_loc()
			if(client)
///				if(dojo())
//					return "[village] dojo respawn"
//				else
				return "[village] respawn"
			else
				return

		knockback(distance,angle,time)

			spawn()
				var/T = time
				while(time--)
					sleep(world.tick_lag)
					angle_step(angle,distance/T)

mob/var/village = "red"

obj
	respawns
		red
		blue
		red_dojo
		blue_dojo
		invisibility=1
		New()
			..()
			var/turf/T = locate(x,y,z)
			T.tag = "[name] respawn"

atom/movable
	proc
		angle_step(angle,amount)
			angle = -angle+270+180
			Translate(cos(angle)*amount,sin(angle)*amount)
item
	equipment
atom/movable

	var/tmp/pewt=1
	var/tmp/hit_walls=1
	var/tmp/only_cross
	var/pewt_state
	var/pewt_blend

	proc/sparkle()
		var/obj/o = new/obj
		o.icon = 'effects.dmi'
		o.icon_state = "sparkle"
		o.pewt = 2
		o.pixel_y = pixel_y
		o.pixel_x = pixel_x
		o.SetCenter(Cx(),Cy(),z)
		o.spawndel(5)
		o.pewt()
		o.invisibility=3

	proc/pewt()
		for(var/i in 1 to 5)
			var angle = rand(360)

			var obj/o = new
			o.SetCenter(Cx(), Cy(), z)
			o.icon = icon
			o.color = color
			o.layer = layer
			o.standing=0

			o.icon_state = pewt_state ? pewt_state : icon_state
			o.pixel_y = pixel_y
			o.pixel_x = pixel_x
			o.blend_mode = pewt_blend ? pewt_blend : blend_mode

			var matrix/a = new
			a.Scale(pewt/2)
			a.Turn(angle)

			var matrix/b = new
			b.Scale(pewt/2)
			b.Translate(0, 20)
			b.Turn(angle)

			o.transform = a
			animate(o, transform = b, alpha = 0, time = 2)
			o.spawndel(3)
obj



	projectile

		bounds = "5,5 to 12,12"

		density = TRUE
		icon = 'effects.dmi'

		var only_players = FALSE
		var densenotime = FALSE

		var floats
		var last_angle
		var angle = 0
		var vel_x = 0
		var vel_y = 0

		proc/hit_owner()
		proc/has_fire()
		var speed = 8

		var iterations
		var max_iterations = 20

		var delay = null
		var instant = FALSE

		var stuck_icon

		var mob/owner
		var mob/lasthit
		var damage = 0
		var can_hit = TRUE


		var atom/movable/pos_owner

		var or_angle
		var time = 10
		standing=0
		var damage_mtype=null
		var damage_mtype2=null
		layer = MOB_LAYER+1
		var/item/equipment/item_owner

		New(mob/m, angle, obj/o,ability/a,item/i)
			..()
			m.contents -= src
			if(!delay)
				delay = world.tick_lag
			if(a)

				ability_owner = a

			owner = m
			item_owner = i

			pos_owner = m
			luminosity=2
			reposition()

			setAngle(angle)
			or_angle = angle
			setOffset(angle)

			do_shit()

			spawn(time)
				if(spawndels)
					del src
		var/tmp/spawndels=1
		proc/setOffset(a)
			if(start_offset)
				Translate(cos(a+start_offset_a)*start_offset,sin(a+start_offset_a)*start_offset)
		var/tmp
			start_offset=0
			start_offset_a=0
		Del()
			if(pewt)
				pewt()
			owner=null
			pos_owner=null
			ability_owner=null
			lasthit=null
			loc=null
			..()


		Bump(atom/m)
			if(ismob(m))
				if(m != owner && m && owner && !(m in cant_collide))
					onHit(m)
				if(!owner)
					onHit(m)

			else if(m != pos_owner)
				if(!istype(m, /obj/projectile))
					wall_hit()
				else
					if(m:owner != owner)
						del(m)
						del(src)


		has_fire()

			return 0
		Cross(atom/o)
			if(istype(o, /obj/projectile/) && o:owner != owner)
				return TRUE


			if(o == owner) return TRUE

			if(o in cant_collide) return TRUE

			return ..()


		proc/do_shit()
			if(!src.loc)
				return

			if(angle != last_angle)
				setAngle(angle)

			Translate(vel_x, vel_y)
//			new/obj/lighting_plane
//			draw_spotlight(-24, -12, "#FFFFFF", 1, 255)
			if(instant)
				iterations ++
				if(iterations == max_iterations && spawndels)
					del src
				else
					do_shit()

			else
				spawn(delay)
					do_shit()

		proc/projectileCollide(obj/projectile/m)
			return TRUE

		var/damage_percent=1
		var/deletesonhit=1
		var/damage_type

		proc/onKill(mob/m)
		proc/getDamage()
			return damage
		var/poisedmg=1

		proc/onHit(mob/m)
			lasthit = m
			if(m.npc==1)
				cant_collide += m
			if(!owner)
				lasthit=null
				return
			if(getDamage())
				m.damage(getDamage(),owner,dtype)
				if(!m || m.dead)
					onKill(m)
			if(istype(m,/mob/ShadowClone))
				del(m)
			if(deletesonhit)
				del src
			else
				cant_collide += m

		var/cant_collide = list()
		var/ability/ability_owner
		proc/reposition()
			dir = pos_owner.dir
			SetCenter(pos_owner.Cx()+pos_owner.x_offset+8, pos_owner.Cy()+pos_owner.y_offset+8, pos_owner.z)

		var/vangle=0
		proc/setAngle(new_angle)
			angle = new_angle
			last_angle = angle

			if(rotates)
				var matrix/M = matrix()
				transform = turn(M, vangle ? vangle : new_angle)
			getVelocity()

		var/rotates=1
		proc/setSpeed(new_speed)
			speed = new_speed
			getVelocity()

		proc/getVelocity()
			vel_x = -cos(angle + 90) * speed
			vel_y = sin(angle + 90) * speed

		proc/wall_hit()
			del src



		proc/trail(t=10)
			var obj/o = new
		//	o.SetCenter(Cx(), Cy(), z)
			o.icon = icon
			o.z = z
			o.y = y
			o.x = x
			o.step_x = step_x
			o.step_y = step_y
			o.icon_state = icon_state
			o.blend_mode = ICON_MULTIPLY
			o.color = color
			o.pixel_y = pixel_y
			o.pixel_x = pixel_x

			var matrix/b = new
			b.Scale(1.5,1.5)
			b.Turn(vangle ? vangle : angle)

			o.transform = b
			o.appearance = appearance
			o.blend_mode = BLEND_ADD
			animate(o, alpha = 0, time = t)
			o.spawndel(t)



		var/dtype="magic"
		fireball
			icon = 'fir.dmi'
			pixel_y = -24
			pixel_x = -32
			layer = 10000
			color = "red"
			pewt_state = "pewt"
			dtype = "magic"


			only_players = TRUE
			time = 4
			speed=8

			damage = 1
			pewt = 2

			Translate(xx,yy)
				trail(1)
				..(xx,yy)
				trails=1
			trail()
				if(trails)
					..()
			var/trails=0
			pewt()
				..()
				pewt_blend = BLEND_ADD
				layer = layer+1
				pewt=1
				..()

			getDamage()
				return (5 * owner.fireball) + owner.int
		icicle

			pewt_state = "water hit"
			dtype = "magic"
			icon_state = "icicle"


			only_players = TRUE
			time = 3
			speed=10

			damage = 1
			pewt = 2

			var/trails=0
			pewt()
				..()
				pewt_blend = BLEND_ADD
				layer = layer+1
				pewt=1
				..()

			onHit(mob/M)
//				M.slowed = world.time + (20*owner.icicle)
//				M.damage_number("slowed")
				..()

			getDamage()
				return (1 * owner.icicle) + owner.int

		senbon

			pewt_state = "light hit"
			dtype = "weapon"
			icon_state = "senbon"


			only_players = TRUE
			time = 6
			speed=13

			damage = 1
			pewt = 2

			var/trails=0
			pewt()
				..()
				pewt_blend = BLEND_ADD
				layer = layer+1
				pewt=1
				..()

			onHit(mob/M)
//				M.slowed = world.time + (20+owner.dex)
//				M.damage_number("slowed")
				..()

			getDamage()
				return 2


		bar

			pewt_state = "light hit"
			dtype = "weapon"
			icon = 'effects64.dmi'
			icon_state = "bar"
			pixel_x = -20
			pixel_y = -25

			only_players = TRUE
			time = 5
			speed=15

			damage = 150

			var/trails=0
			getDamage()
				return damage+(owner.dex/2)

		shuriken

			pewt_state = "light hit"
			dtype = "weapon"
			icon_state = "shuriken"


			only_players = TRUE
			time = 9
			speed=11

			damage = 1
			pewt = 2

			var/trails=0
			pewt()
				..()
				pewt_blend = BLEND_ADD
				layer = layer+1
				pewt=1
				..()

			getDamage()
				return damage+(owner.dex)
		kunai

			pewt_state = "light hit"
			dtype = "weapon"
			icon_state = "kunai"


			only_players = TRUE
			time = 15
			speed=9

			damage = 1
			pewt = 2

			var/trails=0
			pewt()
				..()
				pewt_blend = BLEND_ADD
				layer = layer+1
				pewt=1
				..()

			getDamage()
				return damage+(owner.dex)

		shoot

			pewt_state = "light hit"
			dtype = "weapon"
			icon_state = "shoot"
			color = "white"

			only_players = TRUE
			time = 10
			speed=16
			damage = 4
			pewt = 2

			var/trails=0
/*			pewt()
				..()
				pewt_blend = BLEND_ADD
				layer = layer+1
				pewt=1
				..()
*/
			getDamage()
				return 5
			New()
				..()
				transform = transform * 2
		snipershoot

			pewt_state = "water hit"
			dtype = "magic"
			icon = 'effects64.dmi'
			icon_state = "sniper"

			only_players = TRUE
			time = 20
			speed=25
//			rotates = 0
			damage = 100
			pewt = 0
			var/trailobjs = list()
			var/trails=0
			pewt()
				..()
				pewt_blend = BLEND_ADD
				layer = layer+1
				pewt=1
				..()

			var/hits = list()
			do_shit()
				..()
				for(var/mob/M in obounds(5,src))
					if(owner.can_hurt(M))
						onHit(M)

			onHit(mob/M)
				if(!(M in hits))
					if(M == src.owner) return
					hits += M
					M.knockback((64*3) + (10*2),-kget_angle(src,M),4*3)
//					SetCenter(M.Cx(),M.Cy(),M.z)
					pewt()
					M.damage(getDamage(),owner,"magic")
					del(src)
				..()
			trail()
				if(trails > 1)
					var obj/trail/o = new
					o.SetCenter(Cx(), Cy(), z)
					o.icon = icon
					o.z = z
					o.y = y
					o.x = x
					o.layer = src.layer-1
					o.step_x = step_x
					o.step_y = step_y
					o.icon_state = "snipertrail"
					o.timedel = time+5
					o.color = "blue"
					o.pixel_y = pixel_y
					o.pixel_x = pixel_x
					icon_state = "snipertrail"
					o.appearance = appearance
					icon_state = "sniper"
					trailobjs+=o
			Del()
				for(var/obj/O in trailobjs)
					del(O)
					sleep(0.1)
				..()

			New()
				..()
				transform = transform * 2

			getDamage()
				return damage + owner.int

			Translate(xx,yy)
				trail(10)
				..(xx/2,yy/2)
				trail(10)
				..(xx/2,yy/2)

				trails+=1

			trail()
				if(trails > 1)
					..()

		wave
			pewt_state = "water hit"
			dtype = "magic"
			icon_state = "wave"
			only_players = TRUE
			time = 20
			speed=15
//			rotates = 0
			damage = 1
			pewt = 5

			var/trails=0
			pewt()
				..()
				pewt_blend = BLEND_ADD
				layer = layer+1
				pewt=1
				..()

			var/hits = list()
			do_shit()
				..()
				for(var/mob/M in obounds(16,src))
					if(owner.can_hurt(M))
						onHit(M)

			onHit(mob/M)
				if(!(M in hits))
					hits += M
					M.knockback((64*owner.wave) + (owner.int*2),-kget_angle(src,M),4*owner.wave)
					SetCenter(M.Cx(),M.Cy(),M.z)
					pewt()
					M.damage(getDamage(),owner,"magic")



			New()
				..()
				transform = transform * 2

			getDamage()
				return (2*owner.wave) + owner.int

			Translate(xx,yy)
				trail(10)
				..(xx/2,yy/2)
				trail(10)
				..(xx/2,yy/2)

				trails+=1

			trail()
				if(trails > 1)
					..()

		vine
			pewt_state = "pewt"
			dtype = "magic"
			icon_state = "grabber"

			only_players = TRUE
			time = 80
			speed=1

			damage = 1
			pewt = 2
			New()
				..()
				setSpeed((6*owner.vinespeed)+owner.int)

			Translate(xx,yy)
				trail()
				..(xx/2,yy/2)
				trail()
				..(xx/2,yy/2)

				trails+=1
			do_shit()
				if(returning)
					setAngle(-kget_angle(src,owner)+90)
					for(var/obj/O in obounds(0,src))
						if(O in trailobjs)
							del(O)
				..()
				if(grabbed)
					grabbed.SetCenter(Cx(),Cy(),z)
				if(returning && bounds_dist(src,owner) < 16)
					candel=1
					del(src)

			var/returning=0
			trail()
				if(trails > 1)
					var obj/o = new
					o.SetCenter(Cx(), Cy(), z)
					o.icon = icon
					o.z = z
					o.y = y
					o.x = x
					o.step_x = step_x
					o.step_y = step_y
					o.icon_state = "vine"
					o.color = color
					o.pixel_y = pixel_y
					o.pixel_x = pixel_x
					icon_state = "vine"
					o.appearance = appearance
					icon_state = "grabber"
					trailobjs+=o
			var/trailobjs = list()

			var/candel=0

			Del()
				if(!returning)
					returning = 1
					density=0
					return
				if(returning)
					if(!candel)
						return

				for(var/obj/O in trailobjs)
					del(O)
				owner.doing=0
				..()

			var/trails=0
			pewt()
				..()
				pewt_blend = BLEND_ADD
				layer = layer+1
				pewt=1
				..()
			var/mob/grabbed
			onHit(mob/player/M)
				if(M.can_be_projectile)
					if(M)
						grabbed = M
					..()
			getDamage()
				return 1

mob
	var/tmp/doing=0
	var/tmp/wave=0
mob
	proc/getMouse()
		if(client)
			return client.mouse.angle
obj/trail
	var/timedel = 30
	New()
		..()
		spawn(timedel)
		del(src)