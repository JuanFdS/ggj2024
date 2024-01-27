extends RigidBody2D

@onready var areaRosca: Area2D = %AreaRosca

func _ready():
	areaRosca.area_entered.connect(func(_otra_area):
		collision_layer = 0
		collision_mask = 0
		sleeping = true
		set_physics_process(false)
		rotation_degrees = 90
		global_position = %LamparitaRota.global_position
		%Mensajito.text = "Ganaste, sos une cape!"
	)
	
	body_entered.connect(func(_otra_area):
		pass
	)
	
