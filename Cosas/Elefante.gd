class_name Elefante
extends RigidBody2D

const SPEED = 300.0
var direccion: Vector2 = Vector2.LEFT
var gravity: float = ProjectSettings.get_setting("physics/2d/default_gravity")
var gravity_versor: Vector2 = ProjectSettings.get_setting("physics/2d/default_gravity_vector")
@onready var trompa: StaticBody2D = %Trompa
@onready var origin_x = global_position.x
@onready var timer := %Timer

func _ready():
	$AnimationPlayer.play("trompa")
	trompa.add_collision_exception_with(self)
	trompa.add_collision_exception_with($Elefante)
	timer.timeout.connect(self.avanzar)

func _physics_process(delta):
	pass

func avanzar():
	if [true, false].pick_random():
		cambiar_direccion()

	apply_central_impulse(direccion * SPEED)

func cambiar_direccion():
	direccion *= -1
	$Sprite.scale.x *= -1
	$SpriteTrompa.scale.x *= -1

