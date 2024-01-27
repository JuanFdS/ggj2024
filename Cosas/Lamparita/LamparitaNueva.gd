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
		lamparita_rota.arreglar()
		EstadoDelJuego.se_gano()
		
		queue_free()
	)
	
	body_entered.connect(func(_otra_area):
		Sounds.play_lamp_collision()
	)
	
