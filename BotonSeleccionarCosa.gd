extends TextureButton

@export var tipo_de_cosa: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():	
	pressed.connect(func():
		EstadoDelJuego.tipo_de_cosa_seleccionada = tipo_de_cosa
	)
