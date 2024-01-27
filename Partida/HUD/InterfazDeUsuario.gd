extends CanvasLayer

const BOTON_TIPO_DE_COSA = preload("res://Partida/HUD/BotonTipoDeCosa.tscn")

signal reiniciar

func configurar_tipos_de_cosas(tipos_de_cosas: Array[TipoDeCosa]):
	%MenuDeCosas.get_children().map(func(boton):
		if boton is BotonTipoDeCosa:
			%MenuDeCosas.remove_child(boton)
			boton.queue_free()
	)
	tipos_de_cosas.map(func(tipo_de_cosa):
		var boton = BOTON_TIPO_DE_COSA.instantiate()
		boton.tipo_de_cosa = tipo_de_cosa
		%MenuDeCosas.add_child(boton, true)
	)
	if(tipos_de_cosas.size() == 1):
		EstadoDelJuego.tipo_de_cosa_seleccionada = tipos_de_cosas.front()
		%MenuDeCosas.hide()
	else:
		show()

func _ready():
	%BotonReiniciar.pressed.connect(func(): reiniciar.emit())

func _process(_delta):
	%Contador.text = " + ".join(EstadoDelJuego.cantidad_de_cosas.keys().map(func(cosa):
		var cantidad = EstadoDelJuego.cantidad_de_cosas[cosa]
		return "%d × %s" % [cantidad, cosa]
	))
	
	if(EstadoDelJuego.ganado):
		%Mensajito.text = "¡Ganaste!"
	
