#include <kaiochao\shapes\shapes.dme>

/* This is a demonstration of the main purpose of this library, which is
to provide a method of movement that is not limited by having positions
rounded to whole pixels.

The demonstration consists of a solar system with the Sun and two planets
that orbit around the Sun according to the same real physics equations.

The red planet follows native pixel movement behavior by ignoring the
fractional parts of its movements. Moving slowly means not moving at all.

The blue planet follows a more physically realistic behavior by preserving
the fractional parts of its movements.
It is able to move slow enough that it doesn't always change location between frames.

Which one looks better to you? Why was pixel movement implemented this way?
*/

world
	maxx = 21
	maxy = 21
	view = 10
	fps = 60
	turf = /turf/space

	New()
		var width = maxx * TILE_WIDTH
		var height = maxy * TILE_HEIGHT

		var obj/planet/sun/sun = new
		sun.SetCenter(width / 2, height / 2, 1)

		var obj/planet/earth/earth = new
		earth.SetCenter(1/3 * width, 1/2 * height, 1)

		var obj/planet/glitchy_earth/glitchy_earth = new
		glitchy_earth.SetCenter(earth)

		spawn for()
			sleep world.tick_lag

			// Vector from the Earth to the Sun
			var dx = sun.Cx() - (earth.Cx() + earth.fractional_x)
			var dy = sun.Cy() - (earth.Cy() + earth.fractional_y)

			// Gravitational acceleration
			var gravity = 0.003 * (dx * dx + dy * dy) ** (-1/3)
			var gravity_x = dx * gravity
			var gravity_y = dy * gravity

			// Apply gravitational acceleration to the Earth
			earth.velocity_x += gravity_x
			earth.velocity_y += gravity_y

			// Move the Earth by its current velocity
			earth.Translate(earth.velocity_x, earth.velocity_y)


			// Perform the same calculations for gravity between the Glitchy Earth and the Sun.

			// Vector from the Glitchy Earth to the Sun
			dx = sun.Cx() - glitchy_earth.Cx()
			dy = sun.Cy() - glitchy_earth.Cy()

			// Gravitational acceleration
			gravity = 0.003 * (dx * dx + dy * dy) ** (-1/3)
			gravity_x = dx * gravity
			gravity_y = dy * gravity

			// Apply gravitational acceleration to the Earth
			glitchy_earth.velocity_x += gravity_x
			glitchy_earth.velocity_y += gravity_y

			// Rounding the velocity is the same as not preserving the fractional movements.
			// When you don't preserve fractional movements, you can only move by whole pixels.
			// This means that when you're moving slow enough, you're not moving at all.
			// If you're moving a bit faster, you might move one pixel in one of the 8 BYOND directions.
			// The faster you go, the better the approximation becomes, but still.
			glitchy_earth.Translate(round(glitchy_earth.velocity_x), round(glitchy_earth.velocity_y))

			// Apply a bit of drag to everything.
			var drag = 0.995
			earth.velocity_x *= drag
			earth.velocity_y *= drag
			glitchy_earth.velocity_x *= drag
			glitchy_earth.velocity_y *= drag

turf/space
	icon_state = "rect"
	color = "#050505"
	New()
		if(prob(50))
			var obj/star/star = new (src)
			star.step_x = rand(31)
			star.step_y = rand(31)

obj/star
	icon_state = "rect"
	transform = matrix(1/32, 0, 0, 0, 1/32, 0)
	bounds = "1,1"

obj/planet
	icon_state = "oval"

	sun
		color = "yellow"
		transform = matrix(2, 0, 0, 0, 2, 0) // solar system not to scale

	earth
		layer = MOB_LAYER
		color = "blue"
		transform = matrix(1/3, 0, 0, 0, 1/3, 0)
		bounds = "15,15 to 16,16"

		var
			velocity_x = 0
			velocity_y = 2

	glitchy_earth
		layer = MOB_LAYER
		color = "red"
		transform = matrix(1/3, 0, 0, 0, 1/3, 0)
		bounds = "15,15 to 16,16"

		var
			velocity_x = 0
			velocity_y = 2
