turf
	estrada
//		New()
//			..()
//			icon_state = "[src.name]"
//		layer = 1
		estradadeterra
			name = "13"
			icon = 'estrada de terra.dmi'
			icon_state = "13"
		estradadebrick
			name = "13"
			icon = 'estrada de brick.dmi'
			icon_state = "13"
			estradadebrick1
				icon = 'estrada de brick.dmi'
				icon_state = "1"
			estradadebrick2
				icon = 'estrada de brick.dmi'
				icon_state = "2"
			estradadebrick3
				icon = 'estrada de brick.dmi'
				icon_state = "3"
			estradadebrick4
				icon = 'estrada de brick.dmi'
				icon_state = "4"
			estradadebrick5
				icon = 'estrada de brick.dmi'
				icon_state = "5"
			estradadebrick6
				icon = 'estrada de brick.dmi'
				icon_state = "6"
			estradadebrick7
				icon = 'estrada de brick.dmi'
				icon_state = "7"
			estradadebrick8
				icon = 'estrada de brick.dmi'
				icon_state = "8"

turf
	ColoredTittle
		icon = 'Pixelsphe.dmi'
		var
			maxstate = 0
			list/coloredstates=list("b","br","pi","y","g","red","p","w","old")
		New()
			..()
			icon_state = "[src.name]"
		b
			maxstate = 23
			b
			b1
			b2
			b3
			b4
			b5
			b6
			b7
			b8
			b9
			b10
			b11
			b12
			b13
			b14
			b15
			b16
			b17
			b18
			b19
			b20
			b21
			b22
			b23
		br
			maxstate = 19
			br
			br1
			br2
			br3
			br4
			br5
			br6
			br7
			br8
			br9
			br10
			br11
			br12
			br13
			br14
			br15
			br16
			br17
			br18
			br19

		pi
			maxstate = 2
			pi
			pi1
			pi2

		black
			icon_state = "black"

		y
			maxstate = 3
			yi
			yi1
			yi2
			yi3

		g
			maxstate = 14
			g
			g1
			g2
			g3
			g4
			g5
			g6
			g7
			g8
			g9
			g10
			g11
			g12
			g13
			g14

		red
			maxstate = 10
			red
			red1
			red2
			red3
			red4
			red5
			red6
			red7
			red8
			red9
			red10

		p
			maxstate = 12
			p
			p1
			p2
			p3
			p4
			p5
			p6
			p7
			p8
			p9
			p10
			p11
			p12

		w
			maxstate = 8
			w
			w1
			w2
			w3
			w4
			w5
			w6
			w7
			w8

		old
			maxstate = 1
			old
			old1