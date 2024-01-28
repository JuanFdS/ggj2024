extends Node

const GALLINA = preload("res://TiposDeCosa/Gallina.tres")

var tipo_de_cosa_seleccionada: TipoDeCosa = GALLINA
var cantidad_de_cosas := {}
var tiempo := 0.0
var ganado: bool
var mensaje_ganador: String

var contando_el_tiempo := false

signal inicio_nivel

# Called when the node enters the scene tree for the first time.
func _ready():
	inicializar()

func _physics_process(delta):
	if(contando_el_tiempo):
		tiempo += delta

# Called every frame. 'delta' is the elapsed time since the previous frame.
func spawnear_cosa() -> PhysicsBody2D:
	if not ganado:
		cantidad_de_cosas[tipo_de_cosa_seleccionada.nombre] = cantidad_de_cosas.get(tipo_de_cosa_seleccionada.nombre, 0) + 1
		contando_el_tiempo = true
	return tipo_de_cosa_seleccionada.escena.instantiate()
	
func inicializar():
	tiempo = 0.0
	cantidad_de_cosas = {}
	ganado = false
	contando_el_tiempo = false
	inicio_nivel.emit()
	
func reiniciar():
	Sounds.stop_all_sounds()
	inicializar()

func se_gano(mensaje = "¡Ganaste!"):
	mensaje_ganador = mensaje
	EstadoDelJuego.partida_ganada(cantidad_de_cosas, tiempo)
	Sounds.play_lamp_win()
	ganado = true
	contando_el_tiempo = false
	SaveGame.save_game(get_tree())
