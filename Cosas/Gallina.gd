extends RigidBody2D

@onready var shiny_particles: CPUParticles2D = $ShinyParticles

func _ready():
	$AnimatedSprite2D.play()
	Sounds.play_gallina()
	if(randf() < 0.05):
		$AnimatedSprite2D.modulate = Color("de9b57")
		shiny_particles.restart()

func _process(_delta):
	pass
