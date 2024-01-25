extends RigidBody2D

@onready var area: Area2D = %Area

func _ready():
	area.area_entered.connect(func(otro_area):
		collision_layer = 0
		collision_mask = 0
		sleeping = true
		set_physics_process(false)
		rotation_degrees = 90
		global_position = %LamparitaRota.global_position
		%Mensajito.text = "Ganaste, sos une cape!"
	)
