extends Node2D

var cantidad_gallinas = 1

func _ready():
	%BotonReiniciar.pressed.connect(func():
		EstadoDelJuego.reiniciar()
		get_tree().reload_current_scene()
	)

func _process(_delta):
	%Contador.text = "Gallinas: %s" % EstadoDelJuego.cantidad_de_cosas

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MouseButton.MOUSE_BUTTON_LEFT and not event.is_echo():
		var nueva_gallina = EstadoDelJuego.spawnear_cosa()
		agregar_en(nueva_gallina, event.global_position)
		
		$SpawnSfx.play()
		cantidad_gallinas += 1
		
func agregar_en(cosa, posicion_global):
	add_child(cosa)
	cosa.global_position = posicion_global
