extends Node2D

const velocidad_maxima_cosa = Vector2(1000, 1000)

var ultima_posicion_cursor: Vector2
var velocidad_cursor: Vector2

func _ready():
	%BotonReiniciar.pressed.connect(func():
		EstadoDelJuego.reiniciar()
		get_tree().reload_current_scene()
	)

func _process(delta):
	%Contador.text = " + ".join(EstadoDelJuego.cantidad_de_cosas.keys().map(func(cosa):
		var cantidad = EstadoDelJuego.cantidad_de_cosas[cosa]
		return "%d × %s" % [cantidad, cosa]
	))
	
	if(EstadoDelJuego.ganado):
		%Mensajito.text = "¡Ganaste!"
	
	var posicion_actual_cursor = get_viewport().get_mouse_position()

	velocidad_cursor = (posicion_actual_cursor - ultima_posicion_cursor) / delta
	ultima_posicion_cursor = posicion_actual_cursor

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MouseButton.MOUSE_BUTTON_LEFT and not event.is_echo():
		var posicion_cursor = event.global_position / get_viewport().get_camera_2d().zoom * TamanioVentana.escala_del_viewport()
		var nueva_cosa = EstadoDelJuego.spawnear_cosa()
		
		agregar_en(posicion_cursor, nueva_cosa)
		
		Sounds.play_spawn()
		
func agregar_en(posicion_global, cosa):
	var velocidad_cosa = clamp(velocidad_cursor, -velocidad_maxima_cosa, velocidad_maxima_cosa)
	
	add_child(cosa)
	cosa.global_position = posicion_global
	cosa.apply_central_impulse(velocidad_cosa)
