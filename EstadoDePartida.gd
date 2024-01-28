extends Node

const GALLINA = preload("res://TiposDeCosa/Gallina.tres")

var tipo_de_cosa_seleccionada: TipoDeCosa = GALLINA
var cantidad_de_cosas := {}
var ganado: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	inicializar()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func spawnear_cosa() -> RigidBody2D:
	cantidad_de_cosas[tipo_de_cosa_seleccionada.nombre] = cantidad_de_cosas.get(tipo_de_cosa_seleccionada.nombre, 0) + 1
	return tipo_de_cosa_seleccionada.escena.instantiate()
	
func inicializar():
	cantidad_de_cosas = {}
	ganado = false
	
func reiniciar():
	Sounds.stop_all_sounds()
	inicializar()

func se_gano():
	Sounds.play_lamp_win()
	ganado = true