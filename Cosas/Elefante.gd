@tool
class_name Elefante
extends RigidBody2D

const SPEED = 300.0
var direccion: Vector2 = Vector2.LEFT
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_versor: Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
@onready var trompa: StaticBody2D = %Trompa
@onready var origin_x = global_position.x
@onready var timer := %Timer
@onready var area_golpe := %AreaGolpe

func _ready():
	if Engine.is_editor_hint():
		return
	
	animar_trompa_hacia("izquierda")
	trompa.add_collision_exception_with(self)
	timer.timeout.connect(self.avanzar)
	area_golpe.body_entered.connect(func(cosa):
		if(cosa != self):
			self.cosa_golpeada()	
	)

func cosa_golpeada():
	Sounds.play_elefante_revolea()

func _physics_process(_delta):
	if Engine.is_editor_hint():
		return
	pass

func avanzar():
	if [true, false].pick_random():
		cambiar_direccion()

	#apply_central_impulse(direccion * SPEED)

func cambiar_direccion():
	direccion *= -1
	
	if direccion == Vector2.LEFT:
		animar_transicion("derecha", "izquierda")
	else:
		animar_transicion("izquierda", "derecha")
	
	$SpriteTrompa.scale.x *= -1

func animar_transicion(direccion_inicial, direccion_final):
	Sounds.play_elefante_pasos()
	$AnimatedSprite2D.play("%s_a_%s" % [direccion_inicial, direccion_final])
	$SpriteTrompa.visible = false
	$AnimatedSprite2D.animation_finished.connect(func():
		animar_trompa_hacia(direccion_final)
		$SpriteTrompa.visible = true
	, CONNECT_ONE_SHOT)

func animar_trompa_hacia(nombre_direccion):
	$AnimatedSprite2D.play(nombre_direccion)
	$AnimationPlayer.play("trompa_%s" % nombre_direccion)

func play_animations():
	$AnimatedSprite2D.stop()
	$AnimationPlayer.stop()
	
	$AnimatedSprite2D.play("derecha")
	$AnimationPlayer.play("trompa_derecha")

func stop_animations():
	$AnimatedSprite2D.pause()
	$AnimationPlayer.pause()
#
#func _extend_inspector_begin(inspector: ExtendableInspector):
	#var play_animations_button =\
		#CommonControls.new(inspector).method_button("play_animations")
	#var stop_animations_button =\
		#CommonControls.new(inspector).method_button("stop_animations")
#
	#inspector.add_custom_control(play_animations_button)
	#inspector.add_custom_control(stop_animations_button)

