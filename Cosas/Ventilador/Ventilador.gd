extends StaticBody2D

@export var fuerza: float = 500.0
var cosas_ventiladas: Array = []
@onready var area_de_vientito: Area2D = %AreaDeVientito

func _ready():
	area_de_vientito.body_entered.connect(func(cosa):
		cosas_ventiladas.push_back(cosa)
	)
	area_de_vientito.body_exited.connect(func(cosa):
		cosas_ventiladas.erase(cosa)
	)
	# vvv Movimiento vvv
	#var tween = create_tween().set_loops().set_trans(Tween.TRANS_ELASTIC).set_ease(Tween.EASE_IN_OUT)
	#tween.tween_property(self, "rotation", PI / 4.0, 3.0)
	#tween.tween_property(self, "rotation", 0.0, 3.0)

func _physics_process(_delta):
	cosas_ventiladas.map(func(cosa: RigidBody2D):
		cosa.apply_central_force(
			Vector2.RIGHT.rotated(rotation) * fuerza
		)
	)
