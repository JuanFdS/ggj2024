@tool
extends TextureButton

@export var tipo_de_cosa: TipoDeCosa

# Called when the node enters the scene tree for the first time.
func _ready():
	texture_normal = tipo_de_cosa.textura
	if Engine.is_editor_hint():
		return
	
	pressed.connect(func():
		EstadoDelJuego.tipo_de_cosa_seleccionada = tipo_de_cosa
	)
