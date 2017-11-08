////////////////////////////////////// TEMPO TOTAL : +7 HORAS PARA SEPARAR OS NOME E CODAR O MAPA //////////////////////////////////////////////////////////////////////////////////////
obj/Castlearound
	turfs
		density1
			icon = 'density.dmi'
			invisibility = 10
			density = 1
			layer = 20
		Casteloaround
			density = 0
			icon = 'gramaeagua.dmi'
			gramaA
				icon_state="1"
			gramaD
				icon_state="2"
			gramaS
				icon_state="4"
			gramaW
				icon_state="5"
			stone
				icon_state="6"
			importante
				layer = 5
				density = 0
				icon = 'Castle2.dmi'
				blocos3
//					layer = 1000
					icon_state="3blocos"
				linha
					icon_state="linha"
				triangulo
					layer = 5
					icon_state="retosemerro"
				top1
					layer = 5
					icon_state="top1"
				top2
					icon_state="top2"
				top3
					icon_state="top3"
				top4
					icon_state="top4"
				top5
					layer=5
					icon_state="top5"
				top6
					layer=5
					icon_state="top6"
				blocoscastle
					icon_state="3blocoscastle"
turf
	Castlearound
		icon = 'gramaeagua.dmi'
		terrestre
			GRAMA
				grama
					icon_state="3"
				grama1
					icon_state="zq4"
				grama2
					icon_state="zq5"
				grama3
					icon_state="zq6"
				grama5
					icon_state="q4"
				grama4
					icon_state="q5"
				grama6
					icon_state="q6"
			GRAMAAGUA
				gramacomagua1
					icon_state="q1"
				gramacomagua2
					icon_state="q2"
				gramacomagua3
					icon_state="q3"
				gramacomagua4
					icon_state="qx1"
				gramacomagua5
					icon_state="qx2"
				gramacomagua6
					icon_state="qx3"
			GRAMA2AGUA
				gramaZQQ
					icon_state="qq1"
				gramaZW
					icon_state="qq2"
				gramaZE
					icon_state="qq3"
			GRAMATIPO2
				gramaZQ1
					icon_state="qq4"
				gramaZW1
					icon_state="qq5"
				gramaZE1
					icon_state="qq6"
		Partedaagua
			density = 1
			rochawater
				icon_state="q7"
			rochawater1
				icon_state="q8"
			rochawater2
				icon_state="q9"
			cacho1
				icon_state="cacho1"
			cacho2
				icon_state="cacho2"
			cacho3
				icon_state="cacho3"
			watercenter
				icon_state="watercenter"
turf/Castelo
	icon = 'Castle2.dmi'
	trilhos1
		icon_state="trilhos1"
		layer = 10
///		Layer=6
	trilhos2
		icon_state="trilhos2"
		layer = 10
//		Layer=6
	escada
		density = 0
//		Layer = 5
		layer = MOB_LAYER-1
		escadatopo
			icon_state="escadatopo"
		escada
			icon_state="escadatopo"
		escadainicio
			icon_state="escadainicio"
/*		New()
			var/turf/T = get_step(src,NORTH)
			if(T)
				Layer = T.Layer - 1
			..()*/
	Portao
		PortaoFechado1
			icon = 'Castle2.dmi'
			parte1
				icon_state="t1"
			parte2
				icon_state="t2"
			parte3
				icon_state="t3"
			parte4
				icon_state="t4"
			parte5
				icon_state="t5"
			parte6
				icon_state="t6"
			parte7
				icon_state="t7"
			parte8
				icon_state="t8"
			parte9
				icon_state="t9"
			zab1
				icon_state="ab1"
			zab2
				icon_state="ab2"
			zab3
				icon_state="ab3"
		PortaoAberto1
			layer = 5
			parte1
				layer = 10
				icon_state="tt1"
			parte2
				layer = 10
				icon_state="tt2"
			parte3
				layer = 10
				icon_state="tt3"
			parte4
				layer = MOB_LAYER-1
				icon_state="tt4"
			parte5
				layer = MOB_LAYER-1
				icon_state="tt5"
			zab1
				layer = MOB_LAYER-1
				icon_state="ab1"
			zab2
				layer = MOB_LAYER-1
				icon_state="ab2"
			zab3
				layer = MOB_LAYER-1
				icon_state="ab3"
			zab6
				layer = 9
				icon_state="zab6"
			zab7
				layer = 9
				icon_state="zab7"
			zab8
				layer = 9
				icon_state="zab8"
			zab9
				icon_state="zab9"
			zab9a
				icon_state="zab10"
			zab9b
				icon_state="zab11"
		PortaAberta
			aberto1
				icon_state="aberto1"
			aberto2
				icon_state="aberto2"
			aberto3
				icon_state="aberto3"
			aberto4
				icon_state="aberto4"
			portaaberta1
				icon_state="portaaberta1"
			portaaberta2
				icon_state="portaaberta2"
			completarafechadura
				icon_state="topoquefalta"
			topoaberto
				icon_state="topoaberto"
			topoaberto
				icon_state="topoaberto12"
	Paredes
		density = 1
		Faltando
			parte1
				icon_state="p1"
			parte2
				icon_state="p2"
			parte3
				icon_state="p3"
			parte4
				icon_state="p4"
			parte5
				icon_state="p5"
			parte6
				icon_state="p6"
			parte7
				icon_state="p7"
			parte8
				icon_state="p8"
			parte9
				icon_state="p9"
		Completo
			centro
				icon_state="centro"
			baixo
				icon_state="baixo"
			centrocomblocofora
				icon_state="centrocomblocofora"
			trilhos
				density = 0
//				Layer = 6
				icon_state="trilhos"
			trilhosinside
				density = 0
				icon_state="trilhosinside"
			trilhos1layer
				layer = 1
				icon_state="trilhos"
			trilhos1layer100
				layer = 10
				density = 0
				icon_state="trilhos"
			janela
				layer = 20
				icon_state="janela"
			ter4
				icon_state="ter4"
			ter5
				icon_state="ter5"
			finalborda1
				layer = MOB_LAYER-1
				icon_state="finalborda1"
			finalborda2
				layer = MOB_LAYER-1
				icon_state="finalborda2"
			finalborda3
				layer = MOB_LAYER-1
				icon_state="finalborda3"
			dente1
				icon_state="1dente"
			dente2
				icon_state="2dente"
			dente3
				icon_state="3dente"
			dente4
				icon_state="4dente"
			ter4
				icon_state="ter4"
			paredetest
				icon_state="paredetest"
		Teste
			test1
				icon_state="test1"
			test2
				icon_state="test2"
obj/turfs
	CasteloObjetos
		density = 0
		icon = 'Castle2.dmi'
		UmaTorre
			layer = MOB_LAYER-1
			finalborda1
				icon_state="torre0"
				layer = 7
			finalborda2
				icon_state="torre0.1"
				layer = MOB_LAYER-1
			finalborda3
				icon_state="torre0.2"
				layer = 7
			ter1
				layer = 10
				icon_state="ter1"
			ter2
				layer = 10
				icon_state="ter2"
			ter33
				layer = 10
				icon_state="ter3"
			ter5
				layer = 10
				icon_state="ter5"
			ter6
				layer = 10
				icon_state="ter6"
			ter7
				layer = 10
				icon_state="ter7"
			sodente1
				icon_state="sodente1"
			sodente2
				icon_state="sodente2"
			sodente3
				icon_state="sodente3"
obj/turfs
	CasteloObjetos
		density = 0
		icon = 'Castle2.dmi'
		Flags
//			layer = 1003
			fr1
				icon_state="fr1"
			fr2
				icon_state="fr2"
			fr3
				icon_state="fr3"
			fb1
				icon_state="fb1"
			fb2
				icon_state="fb2"
			fb3
				icon_state="fb3"
		Arvore
			layer = 5
			ar1
				density = 0
				icon_state="ar1"
			ar2
				density = 0
				icon_state="ar2"
			ar3
				icon_state="ar3"
			ar4
				density = 0
				icon_state="ar4"
			ar5
				density = 0
				icon_state="ar5"
			ar6
				density = 0
				icon_state="ar6"
			ar7
				layer = MOB_LAYER-1
				density = 1
				icon_state="ar7"
			ar8
				layer = MOB_LAYER-1
				bound_width  = 15
				density = 1
			icon_state="ar8"
		crate
			icon_state="crate"
		crate1
			icon_state="crate1"
		crate2
			icon_state="crate2"
		crate3
			icon_state="crate3"
		crate4
			icon_state="crate4"
		crate5
			density = 1
			bound_x = 20
			bound_height = 10
			bound_width = 10
			icon_state="crate5"
		crate6
			icon_state="crate6"
		metalcrate
			icon_state="metalcrate"
		minimetalcrate
			icon_state="minimetalcrate"
		goldcrate
			icon_state="goldcrate"
		minigoldcrate
			icon_state="minigoldcrate"
		miniapple
			icon_state="miniapplecrate"
		pote
			icon_state="pote"
		poste1
			icon_state="post1"
		poste2
			icon_state="post2"
		poste3
			icon_state="post3"
		banco1
			density = 0
			icon_state="banco1"
		banco2
			density = 0
			icon_state="banco2"
		banco3
			density = 0
			icon_state="banco3"
		banco4
			density = 0
			icon_state="banco4"
		troncomacahdo
			icon_state="troncomacahdo"
		lampada
			density = 0
//			layer = 1002
			icon_state="lampada"
		simboloespada
			icon_state="simboloespada"
		ferrovil
			icon_state="ferrovil"
		ferrovil1
			icon_state="ferrovil1"
		ferrovil2
			icon_state="ferrovil2"
		ferrovil3
			icon_state="ferrovil3"
		simbolobatalha
			icon_state="simbolobatalha"
		simbolopot
			icon_state="simbolopot"
		simbolobomba
			icon_state="simbolobomba"
		simbolonatureza
			icon_state="simbolonatureza"
		simboloescudo1
			icon_state="simboloescudo1"
		simboloescudo2
			icon_state="simboloescudo2"
		mercado
			mercado1
				icon_state="mercado1"
			mercado2
				icon_state="mercado2"
			mercado3
				icon_state="mercado3"
			mercado4
				icon_state="mercado4"
		fonte
			fonte1
				bound_x = 20
				bound_height = 15
				bound_width = 10
				density = 1
				icon_state="fonte1"
			fonte2
//				density = 1
				icon_state="fonte2"
			fonte3
				icon_state="fonte3"
			fonte4
				icon_state="fonte4"
		poco
			poco1
				icon_state="poço1"
			poco2
				icon_state="poço2"
			poco3
				icon_state="poço3"
			poco4
				icon_state="poço4"
		estatua
			estatua1
				layer = MOB_LAYER-1
				bound_height = 14
				bound_width  = 17
//				bound_height = 14
				density = 1
				icon_state="estatua1"
			estatua2
				layer = MOB_LAYER-1
				density = 1
				bound_width  = 15
				icon_state="estatua2"
			estatua3
				density = 0
				layer = MOB_LAYER-1
				icon_state="estatua3"
			estatua4
				layer = MOB_LAYER-1
				density = 1
				bound_height = 10
				bound_width  = 17
				icon_state="estatua4"
		caveira
			icon_state="caveira"
obj/turfs
	objetos
		icon = 'objetos.dmi'
		vasocomplanta
			icon_state = "vaso"
		vaso1
			icon_state = "vaso1"
		vasoquebrado
			icon_state = "quebrado"
		c1
			icon_state = "c1"
		c
			icon_state = "c"
		p
			icon_state = "p"
		big
			icon_state = "big"
		bigtop
			icon_state = "bigtop"
		small
			icon_state = "small"
		small1
			icon_state = "small1"
		small2
			icon_state = "small2"
