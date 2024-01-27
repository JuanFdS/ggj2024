extends Node2D

func _ready():
	cargar_habitacion(EstadoDelJuego.nivel_actual)
	%InterfazDeUsuario.reiniciar.connect(func():
		EstadoDePartida.reiniciar()
		get_tree().reload_current_scene()
	)
	%InterfazDeUsuario.configurar_tipos_de_cosas(EstadoDelJuego.nivel_actual.tipos_de_cosas)

func cargar_habitacion(nivel: Nivel):
	$Habitacion.add_child(nivel.escena.instantiate())
