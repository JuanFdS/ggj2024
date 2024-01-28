class_name BotonSeleccionDeNivel
extends MarginContainer

@export var nivel: Nivel

func _ready():
	#%Button.focus_entered.connect(self.on_focus_entered)
	#%Button.focus_exited.connect(self.on_focus_exited)
	%Button.text = ""
	%Button.pressed.connect(self.empezar_nivel)
	nivel.tipos_de_cosas.map(func(tipo_de_cosa: TipoDeCosa):
		var textura = TextureRect.new()
		textura.texture = tipo_de_cosa.textura
		textura.expand_mode = TextureRect.EXPAND_IGNORE_SIZE
		textura.custom_minimum_size = Vector2(80, 80)
		%Iconos.add_child(textura, true)
	)
	%Label.text = "%s\n%s" % [tr(nivel.nombre), EstadoDelJuego.puntajes_altos_como_texto_para(nivel)]

func focuseate():
	%Button.grab_focus()

#func on_focus_entered():
	#create_tween().tween_property(
		#%Button,
		#"custom_minimum_size",
		#Vector2(120, 120),
		#0.1)
#
#func on_focus_exited():
	#create_tween().tween_property(
		#%Button,
		#"custom_minimum_size",
		#Vector2(100, 100),
		#0.1)

func empezar_nivel():
	EstadoDelJuego.empezar_nivel(nivel)
