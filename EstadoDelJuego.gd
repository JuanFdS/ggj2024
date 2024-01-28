extends Node

const PARTIDA = preload("res://Partida/Partida.tscn")

enum { CANTIDAD, TIEMPO }

@export var niveles: Array[Nivel] = []
@onready var nivel_actual = niveles.front()
var puntajes_mas_altos: Dictionary = {}
var jugando = false

func _ready():
	SaveGame.load_game(get_tree())

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
	EstadoDePartida.tipo_de_cosa_seleccionada = nivel.tipos_de_cosas.front()
	jugando = true

func partida_ganada(cantidad_de_cosas, tiempo):
	var nuevo_puntaje = PuntajeMasAlto.new(cantidad_de_cosas, tiempo)
	if(not puntajes_mas_altos.has(nivel_actual.resource_path)):
		puntajes_mas_altos[nivel_actual.resource_path] = {}
	puntajes_mas_altos[nivel_actual.resource_path].keys().map(func(tipo_puntaje):
		var puntaje_previo = puntajes_mas_altos[nivel_actual.resource_path][tipo_puntaje]
		var puntaje_que_queda = puntaje_previo.menor_segun(nuevo_puntaje, tipo_puntaje)
		puntajes_mas_altos[nivel_actual.resource_path][tipo_puntaje] = puntaje_que_queda
	)
	puntajes_mas_altos[nivel_actual.resource_path][CANTIDAD] = nuevo_puntaje
	puntajes_mas_altos[nivel_actual.resource_path][TIEMPO] = nuevo_puntaje

func puntajes_altos_para_nivel(nivel: Nivel):
	if(not puntajes_mas_altos.has(nivel.resource_path)):
		puntajes_mas_altos[nivel.resource_path] = {}
	return puntajes_mas_altos[nivel.resource_path]

func puntajes_altos_como_texto_para(nivel: Nivel):
	var puntajes = puntajes_altos_para_nivel(nivel)
	return "".join(puntajes.keys().map(func(tipo_puntaje):
		if(puntajes.has(tipo_puntaje)):
			return str(puntajes[tipo_puntaje].como_texto(tipo_puntaje), "\n")
		else:
			return ""
	))

func save_data():
	var serialized_puntajes_mas_altos = {}
	puntajes_mas_altos.keys().map(func(nivel):
		serialized_puntajes_mas_altos[nivel] = {}
		if(puntajes_mas_altos.has(nivel)):
			puntajes_mas_altos[nivel].keys().map(func(tipo_puntaje):
				serialized_puntajes_mas_altos[nivel][tipo_puntaje] = \
					puntajes_mas_altos[nivel][tipo_puntaje].serializado()
			)
	)
	return serialized_puntajes_mas_altos

func load_data(data):
	puntajes_mas_altos = {}
	data.keys().map(func(nombre_nivel):
		puntajes_mas_altos[nombre_nivel] = {}
		data[nombre_nivel].keys().map(func(tipo_puntaje):
			var puntaje = data[nombre_nivel][tipo_puntaje]
			puntajes_mas_altos[nombre_nivel][int(tipo_puntaje)] = \
				PuntajeMasAlto.new(
					puntaje["cantidad_de_cosas"]
					, puntaje["tiempo"]
				)
		)
	)

class PuntajeMasAlto:
	var cantidad_de_cosas: Dictionary = {}
	var tiempo: float = 0.0
	
	func serializado():
		return { "cantidad_de_cosas": cantidad_de_cosas, "tiempo": tiempo }
	
	func _init(_cantidad_de_cosas, _tiempo):
		_cantidad_de_cosas.keys().map(func(cosa):
			cantidad_de_cosas[cosa] = _cantidad_de_cosas[cosa]	
		)
		tiempo = _tiempo
	
	func como_texto(tipo_puntaje):
		match tipo_puntaje:
			CANTIDAD:
				return "%s " % tr("Menor cantidad:") + " + ".join(cantidad_de_cosas.keys().map(func(cosa):
					var cantidad = cantidad_de_cosas[cosa]
					return "%d × %s" % [cantidad, tr(cosa)]
				))
			TIEMPO:
				return "%s %.2fs" % [tr("Mejor tiempo:"), tiempo]

	func menor_segun(otro_puntaje, tipo_puntaje):
		match tipo_puntaje:
			CANTIDAD:
				return otro_puntaje if otro_puntaje.uso_menos_cosas_que(self) else self
			TIEMPO:
				return otro_puntaje if otro_puntaje.tardo_menos_que(self) else self
	
	func cantidad_total():
		return cantidad_de_cosas.keys().reduce(func(acum, tipo_cosa):
			var cantidad = cantidad_de_cosas[tipo_cosa]
			return cantidad + acum,
			0
		)
	
	func uso_menos_cosas_que(otro_puntaje_mas_alto):
		return cantidad_total() < otro_puntaje_mas_alto.cantidad_total()
	
	func tardo_menos_que(otro_puntaje_mas_alto):
		return tiempo < otro_puntaje_mas_alto.tiempo
