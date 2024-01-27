extends Node2D

const CUANTAS_GALLINAS = preload("res://Partida/Habitaciones/Niveles/CuantasGallinas/CuantasGallinas.tscn")

func _ready():
	cargar_habitacion(CUANTAS_GALLINAS)

func cargar_habitacion(escena: PackedScene):
	$Habitacion.add_child(escena.instantiate())
