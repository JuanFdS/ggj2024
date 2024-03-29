extends Node2D

@export var game_scene:PackedScene
@export var settings_scene:PackedScene

@onready var overlay := %FadeOverlay
@onready var new_game_button := %NewGameButton
@onready var settings_button := %SettingsButton
@onready var credits_button := %CreditsButton
@onready var titulo := %Titulo

var next_scene = game_scene
var new_game = true

const CursorPiolita = preload("res://Assets/Cursor.png")

func _ready() -> void:
	Sounds.play_musica()
	Input.set_custom_mouse_cursor(CursorPiolita, Input.CURSOR_IBEAM)
	Input.set_custom_mouse_cursor(CursorPiolita, Input.CURSOR_POINTING_HAND)
	Input.set_custom_mouse_cursor(CursorPiolita, Input.CURSOR_ARROW)
	cambiar_titulo()
	overlay.visible = true
	new_game_button.disabled = game_scene == null
	settings_button.disabled = settings_scene == null
	
	# connect signals
	new_game_button.pressed.connect(_on_play_button_pressed)
	settings_button.pressed.connect(_on_settings_button_pressed)
	credits_button.pressed.connect(_on_credits_button_pressed)
	overlay.on_complete_fade_out.connect(_on_fade_overlay_on_complete_fade_out)

	new_game_button.grab_focus()
	
	%TituloTimer.timeout.connect(self.cambiar_titulo)

func _on_settings_button_pressed() -> void:
	new_game = false
	next_scene = settings_scene
	overlay.fade_out()
	
func _on_play_button_pressed() -> void:
	next_scene = game_scene
	overlay.fade_out()
	
func _on_continue_button_pressed() -> void:
	new_game = false
	next_scene = game_scene
	overlay.fade_out()

func _on_credits_button_pressed() -> void:
	%CreditosContainer.mostrar()

func _on_exit_button_pressed() -> void:
	get_tree().quit()

func _on_fade_overlay_on_complete_fade_out() -> void:
	if new_game and SaveGame.has_save():
		SaveGame.delete_save()
	get_tree().change_scene_to_packed(next_scene)

func cambiar_titulo():
	var se_necesitan_para_cambiar_un_foquito = tr("se_necesitan_para_cambiar_un_foquito")
	var cuantxs = {
		"gallinas": "Cuantas",
		"ingenieros": "Cuantos",
		"elefantes": "Cuantos",
		"personas": "Cuantas",
		"programadores": "Cuantos",
		"sonidistas": "Cuantos",
		"artistas": "Cuantos",
		"game designers": "Cuantos",
		"productores": "Cuantos"
	}
	var nueva_cosa = cuantxs.keys().pick_random()
	titulo.text = "[center]%s
[shake][color=black]%s[/color][/shake]
%s
[/center]" % [tr(cuantxs[nueva_cosa]), "---", se_necesitan_para_cambiar_un_foquito]
	await get_tree().create_timer(0.3).timeout
	titulo.text = "[center]%s
[tornado][color=black]%s[/color][/tornado]
%s
[/center]" % [tr(cuantxs[nueva_cosa]), tr(nueva_cosa), se_necesitan_para_cambiar_un_foquito]
