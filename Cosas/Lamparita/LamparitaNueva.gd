extends RigidBody2D

@onready var areaRosca: Area2D = %AreaRosca

func _ready():
	areaRosca.area_entered.connect(func(area_otra_lamparita):
		collision_layer = 0
		collision_mask = 0
		sleeping = true
		set_physics_process(false)
		rotation_degrees = 90
		var lamparita_rota = area_otra_lamparita.get_parent()
		global_position = lamparita_rota.global_position
		%Luz.visible = true
		EstadoDelJuego.se_gano()
	)
	
	body_entered.connect(func(_otra_area):
		pass
	)
	
