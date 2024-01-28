extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$BotonRotar.button_down.connect(func():
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			$Ventilador.global_rotation -= PI / 10
		else:
			$Ventilador.global_rotation += PI / 10
	)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
