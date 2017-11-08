
// Here is a very basic effect. While the effect is active, the object's
// luminosity is increased by 4. When it stops glowing, the luminosity
// is decreased by 4. Pretty simple.
effect/glow
	effects = "luminosity=3"
	replace = "/effect/brightglow" // glow and brightblow are mutually exclusive
	Start()
		owner << "You start to glow!"
	Finish()
		owner << "You stop glowing."


// Brightglow is an alternative effect to glow. Since glow has brightglow
// in its replace list, and brightglow has glow in its replace list, the
// two are mutually exclusive. The glow effect replaces the brightglow effect,
// and the brightglow effect replaces the glow effect. This is to prevent
// the two from being combined to create a luminosity=9 effect.
effect/brightglow
	effects = "luminosity=6"
	replace = "/effect/glow" // glow and brightblow are mutually exclusive
	Start()
		owner << "You start to glow brightly!"
	Finish()
		owner << "You stop glowing brightly."


// This is an example of having the effects params modify two variables
// instead of just one. This effect will make you invisible and undense.
effect/ghostform
	effects = "density=-1;invisibility=1"
	Start()
		owner << "You feel less attached to the physical realm."
	Finish()
		owner << "You become whole again!"


// This is an example of a common RPG effect: poison. Since this demo
// doesn't actually support any poison effects, we're not going to do
// anything except have messages telling you that you've been
// poisoned, and add an overlay that disappears when the poison
// wears off.
effect/poison
	cycle_time = 25 // poison takes effect every 2.5 seconds.
	Start()
		owner << "You have been poisoned!"
		owner.overlays += 'fm_es_demo_poison.dmi'
	Finish()
		owner << "The poison wears off."
		owner.overlays -= 'fm_es_demo_poison.dmi'
	Cycle()
		owner << "You take poison damage!"
		// would be poison damage here


// This is an example of an effect that uses the Cycle() proc. It also
// has some custom variables used, just so you know that it isn't against
// the rules to have your own variables. :P
// What this does is that every tick it will randomly offset your x and y
// pixel offsets, then when its done, it will set them back, and set them
// again! Until the effect runs out, then it removes any alterations
// and puts you back to the way you were.
effect/displacement
	cycle_time = 1
	var/x_mod = 0
	var/y_mod = 0
	Start()
		owner << "Your form becomes inconsistant."
	Finish()
		owner << "You're back in one piece!"
		owner.pixel_x -= x_mod
		owner.pixel_y -= y_mod
	Cycle()
		owner.pixel_x -= x_mod
		owner.pixel_y -= y_mod
		x_mod = rand(-32, 32)
		y_mod = rand(-32, 32)
		owner.pixel_x += x_mod
		owner.pixel_y += y_mod


// These are the verbs used to activate the effects.

mob/verb/Glow()
	new/effect/glow(src, 10)

mob/verb/GlowBright()
	new/effect/brightglow(src, 10)

mob/verb/Ghostform()
	new/effect/ghostform(src, 10)

mob/verb/Poison()
	new/effect/poison(src, 10)

mob/verb/Displacement()
	new/effect/displacement(src, 100)

