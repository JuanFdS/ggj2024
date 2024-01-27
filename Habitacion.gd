extends Node2D

var cantidad_gallinas = 1
var ultima_posicion_cursor: Vector2
var velocidad_cursor: Vector2

func _ready():
	%BotonReiniciar.pressed.connect(func():
		EstadoDelJuego.reiniciar()
		get_tree().reload_current_scene()
	)

func _process(delta):
	%Contador.text = "Gallinas: %s" % EstadoDelJuego.cantidad_de_cosas
	
	var posicion_actual_cursor = get_viewport().get_mouse_position()
	velocidad_cursor = (posicion_actual_cursor - ultima_posicion_cursor) / delta
	ultima_posicion_cursor = posicion_actual_cursor

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MouseButton.MOUSE_BUTTON_LEFT and not event.is_echo():
		var nueva_gallina: RigidBody2D = EstadoDelJuego.spawnear_cosa()
		var velocidad_maxima = Vector2(1000, 1000)
		nueva_gallina.apply_central_impulse(clamp(velocidad_cursor, -velocidad_maxima, velocidad_maxima))
		agregar_en(nueva_gallina, event.global_position / get_viewport().get_camera_2d().zoom)
		
		$SpawnSfx.play()
		cantidad_gallinas += 1
		
func agregar_en(cosa, posicion_global):
	add_child(cosa)
	cosa.global_position = posicion_global
