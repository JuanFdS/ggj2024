extends Node2D

const LAMPARA_ROTA = preload("res://Assets/lamparita/Lampara rota.png")
const LAMPARA_OK_PRENDIDA = preload("res://Assets/lamparita/Lampara prendida ok.png")

func romper():
	$Sprite2D.texture = LAMPARA_ROTA
	$Luz.visible = false

func arreglar():
	$Sprite2D.texture = LAMPARA_OK_PRENDIDA
	$Luz.visible = true

# Called when the node enters the scene tree for the first time.
func _ready():
	romper()
