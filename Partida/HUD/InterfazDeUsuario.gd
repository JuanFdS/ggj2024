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
	show()

func _ready():
	%Mensajito.visible = false
	%BotonReiniciar.pressed.connect(func(): reiniciar.emit())
	%ProximoNivel.pressed.connect(func(): EstadoDelJuego.avanzar_nivel())
	%BotonMostrarPanelLateral.visible = false
	%BotonEsconderPanelLateral.pressed.connect(func():
		await create_tween().tween_property(
			%PanelLateral, "position:x", 976, 0.4).set_trans(Tween.TRANS_QUAD).finished
		%BotonMostrarPanelLateral.visible = true
	)
	%BotonMostrarPanelLateral.pressed.connect(func():
		%BotonMostrarPanelLateral.visible = false
		await create_tween().tween_property(
			%PanelLateral, "position:x",
			%PosicionInicialPanelLateral.position.x, 0.4).set_trans(Tween.TRANS_QUAD).finished
	)

func _process(_delta):
	%Contador.text = " + ".join(EstadoDePartida.cantidad_de_cosas.keys().map(func(cosa):
		var cantidad = EstadoDePartida.cantidad_de_cosas[cosa]
		return "%d × %s" % [cantidad, tr(cosa)]
	))
	if(%Contador.text.is_empty()):
		%Contador.text = "0x"
	%LabelTimer.text = "%.2fs" % EstadoDePartida.tiempo
	
	if(EstadoDePartida.ganado):
		%Mensajito.visible = true
		%Mensajito.text = EstadoDePartida.mensaje_ganador
		%CantidadValor.text = %Contador.text
		%TiempoValor.text = %LabelTimer.text
		var nivel = EstadoDelJuego.nivel_actual
		%MejorCantidad.text = EstadoDelJuego.puntaje_alto_como_texto_para(nivel, EstadoDelJuego.CANTIDAD)
		%MejorTiempo.text = EstadoDelJuego.puntaje_alto_como_texto_para(nivel, EstadoDelJuego.TIEMPO)
		if(not EstadoDelJuego.puntajes_altos_para_nivel(nivel).is_empty()):
			var mejor_puntaje_cantidad = EstadoDelJuego.puntajes_altos_para_nivel(nivel)[EstadoDelJuego.CANTIDAD]
			var mejor_puntaje_tiempo = EstadoDelJuego.puntajes_altos_para_nivel(nivel)[EstadoDelJuego.TIEMPO]
			%NuevoRecordCantidad.visible =\
				mejor_puntaje_cantidad.cantidad_de_cosas == EstadoDePartida.cantidad_de_cosas
			%NuevoRecordTiempo.visible =\
				mejor_puntaje_cantidad.tiempo == EstadoDePartida.tiempo
			
	
