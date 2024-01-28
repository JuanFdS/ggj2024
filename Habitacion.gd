extends Node2D

const velocidad_maxima_cosa = Vector2(1000, 1000)

var ultima_posicion_cursor: Vector2
var velocidad_cursor: Vector2

func _ready():
	pass

func _process(delta):
	var posicion_actual_cursor = get_viewport().get_mouse_position()

	velocidad_cursor = (posicion_actual_cursor - ultima_posicion_cursor) / delta
	ultima_posicion_cursor = posicion_actual_cursor

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MouseButton.MOUSE_BUTTON_LEFT and not event.is_echo():
		var nueva_cosa = EstadoDePartida.spawnear_cosa()
		
		agregar_en(ultima_posicion_cursor, nueva_cosa)
		
		Sounds.play_spawn()

func agregar_en(posicion_global, cosa):
	var velocidad_cosa = velocidad_cursor.clamp(-velocidad_maxima_cosa, velocidad_maxima_cosa)
	
	add_child(cosa)
	cosa.global_position = posicion_global
	if cosa.has_method("apply_central_impulse"):
		cosa.apply_central_impulse(velocidad_cosa)
		
