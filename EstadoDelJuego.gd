extends Node

const GALLINA = preload("res://Gallina.tscn")

var tipo_de_cosa_seleccionada: PackedScene
var cantidad_de_cosas: int

# Called when the node enters the scene tree for the first time.
func _ready():
	inicializar()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func spawnear_cosa():
	cantidad_de_cosas += 1
	return tipo_de_cosa_seleccionada.instantiate()
	
func inicializar():
	cantidad_de_cosas = 0
	tipo_de_cosa_seleccionada = GALLINA
	
func reiniciar():
	inicializar()
