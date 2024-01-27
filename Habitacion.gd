extends Node2D

const velocidad_maxima_cosa = Vector2(1000, 1000)

var ultima_posicion_cursor: Vector2
var velocidad_cursor: Vector2
@onready var original_windows_size: Vector2 = get_viewport().size

func _ready():
	%BotonReiniciar.pressed.connect(func():
		EstadoDelJuego.reiniciar()
		get_tree().reload_current_scene()
	)

func _process(delta):
	%Contador.text = "Gallinas: %s" % EstadoDelJuego.cantidad_de_cosas
	if(EstadoDelJuego.ganado):
		%Mensajito.text = "¡Ganaste!"
	
	var posicion_actual_cursor = get_viewport().get_mouse_position()

	velocidad_cursor = (posicion_actual_cursor - ultima_posicion_cursor) / delta
	ultima_posicion_cursor = posicion_actual_cursor

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MouseButton.MOUSE_BUTTON_LEFT and not event.is_echo():
		var viewport_scale = original_windows_size / Vector2(get_viewport().size)
		var posicion_cursor = event.global_position / get_viewport().get_camera_2d().zoom * viewport_scale
		var nueva_cosa = EstadoDelJuego.spawnear_cosa()
		
		agregar_en(posicion_cursor, nueva_cosa)
		
		#$SpawnRandomSfx.play_random()
		
func agregar_en(posicion_global, cosa):
	var velocidad_cosa = clamp(velocidad_cursor, -velocidad_maxima_cosa, velocidad_maxima_cosa)
	
	add_child(cosa)
	cosa.global_position = posicion_global
	cosa.apply_central_impulse(velocidad_cosa)
