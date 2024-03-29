@tool
class_name BotonTipoDeCosa
extends PanelContainer

@export var tipo_de_cosa: TipoDeCosa : set = set_tipo_de_cosa
var focused_stylebox
var unfocused_stylebox

# Called when the node enters the scene tree for the first time.
func _ready():
	%Foco.visible = false
	%Boton.texture_normal = tipo_de_cosa.textura
	if Engine.is_editor_hint():
		return
	
	%Boton.mouse_entered.connect(func():
		%Boton.modulate.a = 1
	)
	%Boton.mouse_exited.connect(func():
		%Boton.modulate.a = 0.5
	)
	
	%Boton.pressed.connect(func():
		Sounds.play_select_cosa()
		EstadoDePartida.tipo_de_cosa_seleccionada = tipo_de_cosa
	)

func _process(delta):
	if Engine.is_editor_hint():
		return
	%Foco.visible = EstadoDePartida.tipo_de_cosa_seleccionada == tipo_de_cosa

func set_tipo_de_cosa(nuevo_tipo_de_cosa: TipoDeCosa):
	tipo_de_cosa = nuevo_tipo_de_cosa
	if(is_inside_tree()):
		%Boton.texture_normal = tipo_de_cosa.textura
