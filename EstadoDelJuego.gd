extends Node

const PARTIDA = preload("res://Partida/Partida.tscn")

@export var niveles: Array[Nivel] = []
@onready var nivel_actual = niveles.front()
var jugando = false

func nivel_siguiente_a(nivel: Nivel):
	var nivel_idx = niveles.find(nivel)
	if(niveles.size() > nivel_idx + 1):
		return niveles[nivel_idx + 1]
	else:
		return nivel

func avanzar_nivel(): 
	empezar_nivel(nivel_siguiente_a(nivel_actual))

func empezar_nivel(nivel: Nivel):
	nivel_actual = nivel
	get_tree().change_scene_to_packed(PARTIDA)
	EstadoDePartida.reiniciar()
	jugando = true
