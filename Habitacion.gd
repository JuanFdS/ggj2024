extends Node2D

var cantidad_gallinas = 1

func _ready():
	%BotonReiniciar.pressed.connect(func(): get_tree().reload_current_scene())

func _process(_delta):
	%Contador.text = "Gallinas: %s" % cantidad_gallinas

func _unhandled_input(event):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == MouseButton.MOUSE_BUTTON_LEFT and not event.is_echo():
		var nueva_gallina = $Gallina.duplicate()
		add_child(nueva_gallina)
		nueva_gallina.global_position = event.global_position
		cantidad_gallinas += 1
