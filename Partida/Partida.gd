extends Node2D

func _ready():
	cargar_habitacion(EstadoDelJuego.nivel_actual)

func cargar_habitacion(nivel: Nivel):
	$Habitacion.add_child(nivel.escena.instantiate())
