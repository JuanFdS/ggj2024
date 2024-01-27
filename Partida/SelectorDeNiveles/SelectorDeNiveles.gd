extends PanelContainer

const BOTON_SELECCION_DE_NIVEL = preload("res://Partida/SelectorDeNiveles/BotonSeleccionDeNivel.tscn")

func _ready():
	EstadoDelJuego.jugando = false
	generar_botoncitos()
	%BotonesContainer.get_children().front().focuseate()
	var botones = %BotonesContainer.get_children()
	for i in range(0, botones.size() - 1):
		var boton: Button = botones[i].get_node("Button")
		var siguiente_boton: Button = botones[i + 1].get_node("Button")
		boton.focus_neighbor_right = boton.get_path_to(siguiente_boton)
		siguiente_boton.focus_neighbor_left = siguiente_boton.get_path_to(boton)

func generar_botoncitos():
	EstadoDelJuego.niveles.map(func(nivel):
		var boton = BOTON_SELECCION_DE_NIVEL.instantiate()
		boton.nivel = nivel
		%BotonesContainer.add_child(boton, true)
	)
	
