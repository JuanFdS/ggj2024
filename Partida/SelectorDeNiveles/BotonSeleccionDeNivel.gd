class_name BotonSeleccionDeNivel
extends MarginContainer

@export var nivel: Nivel

func _ready():
	$Button.focus_entered.connect(self.on_focus_entered)
	$Button.focus_exited.connect(self.on_focus_exited)
	$Button.text = nivel.nombre
	$Button.pressed.connect(self.empezar_nivel)

func focuseate():
	$Button.grab_focus()

func on_focus_entered():
	create_tween().tween_property(
		$Button,
		"custom_minimum_size",
		Vector2(120, 120),
		0.1)

func on_focus_exited():
	create_tween().tween_property(
		$Button,
		"custom_minimum_size",
		Vector2(100, 100),
		0.1)

func empezar_nivel():
	EstadoDelJuego.empezar_nivel(nivel)
