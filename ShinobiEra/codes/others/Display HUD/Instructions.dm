/************************************************************************

Display HUD Library

This is used to create a HUD display which lists objects, such as for an
on-HUD inventory. When you add an new object, it will start in the corner
which you define and every new object you add to the HUD will be added to
that row, either progressively left or right depending on where your
start corner is, until the row is full and then it will either move up
or down a column and fill in another row. When the entire box that you've
defined is full, you will not be able to add more objects to the display.

Instructions:

______
Step 1:

	You need to define a new display_hud, which should look like this:

		display_hud/backpack

			start_x = 1
			start_y = 8

			end_x = 4
			end_y = 5

			pixel_offset_x = 0
			pixel_offset_y = 0

			vertical = 0

	The start_x and start_y values represent the corner where objects will
	start being added first - typically the top-left, but this is up to
	user preference. The end_x and end_y values should be the opposite corner,
	so if your start corner is the top-left, then your ending corner should
	be the bottom-right. Assign the coordinates for where you want the start
	and ending corners to be located.

	If your HUD uses pixel offsets, you can offset the display HUD's objects
	using the pixel_offset_x and pixel_offset_y values.

	If you want items to be added by columns instead of by rows (meaning that
	objects are added first up or down instead of left or right), then set
	the vertical value to 1.

______
Step 2:

	You need to create the display HUD for the client that will be using it.
	If this is something which will be used for all players, then you might
	use something like this:

		client
			var/display_hud/backpack/backpack = new()

	Make sure you have a list to store objects in, since that is not
	included as part of this library.

______
Step 3:

	As an example, if each player has their own backpack display HUD which
	is going to display the player's contents list, then we can add new
	items to the display HUD like this:

		mob
			verb/Get(obj/O as obj in view(src, 1))
				if(src.client.backpack.Add(src, O, src.contents))
					src << "You acquired [O]!"
				else
					src << "You don't have any more room!"

	The display_hud.Add() function will add the object to the contents list,
	but it will NOT call the Move() proc. If you want to use Move() to check
	whether an item can be added to the list, you'll have to do that yourself.

	If you want to remove an item from the list, you can do that like this:

		mob
			verb/Drop(obj/O as obj in src.contents)
				if(src.client.backpack.Remove(src, O, src.contents))
					O.loc = src.loc
					src << "You dropped [O]."
				else
					src << "You can not drop [O]!"


	And that's all there is to it!


************************************************************************/