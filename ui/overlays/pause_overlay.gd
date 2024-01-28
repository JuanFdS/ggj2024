extends CenterContainer

signal game_exited

@onready var resume_button := %ResumeButton
@onready var settings_button := %SettingsButton
@onready var exit_button := %ExitButton
@onready var settings_container := %SettingsContainer
@onready var menu_container := %MenuContainer
@onready var back_button := %BackButton
@onready var volver_a_seleccion_de_niveles_button := %VolverASeleccionDeNiveles
@onready var to_main_menu_button := %ToMainMenuButton
const SELECTOR_DE_NIVELES = preload("res://Partida/SelectorDeNiveles/SelectorDeNiveles.tscn")
const MAIN_MENU_SCENE = preload("res://scenes/main_menu_scene.tscn")


func _ready() -> void:
	resume_button.pressed.connect(_resume)
	settings_button.pressed.connect(_settings)
	exit_button.pressed.connect(_exit)
	back_button.pressed.connect(_pause_menu)
	to_main_menu_button.pressed.connect(_to_main_menu)
	volver_a_seleccion_de_niveles_button.pressed.connect(func():
		get_tree().change_scene_to_packed(SELECTOR_DE_NIVELES)
		_resume()
	)
	
func grab_button_focus() -> void:
	resume_button.grab_focus()
	
func _resume() -> void:
	get_tree().paused = false
	visible = false
	
	
func _settings() -> void:
	menu_container.visible = false
	settings_container.visible = true
	back_button.grab_focus()
	
func _exit() -> void:
	game_exited.emit()
	get_tree().quit()

func _to_main_menu():
	get_tree().change_scene_to_packed(MAIN_MENU_SCENE)
	_resume()

func _pause_menu() -> void:
	get_tree().paused = true
	visible = true
	settings_container.visible = false
	menu_container.visible = true
	settings_button.grab_focus()
	
func _unhandled_input(event):
	if event.is_action_pressed("pause") and not visible and EstadoDelJuego.jugando:
		get_viewport().set_input_as_handled()
		_pause_menu()
	elif event.is_action_pressed("pause") and visible:
		get_viewport().set_input_as_handled()
		if menu_container.visible:
			_resume()
		if settings_container.visible:
			_pause_menu()
