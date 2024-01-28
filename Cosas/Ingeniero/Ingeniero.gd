class_name Ingeniero
extends RigidBody2D

var lamparita_a_buscar = null

enum Estado { Paveando, BuscandoLamparita, LamparitaEnMano, Enchufado }

var estado = Estado.Paveando

func _ready():
	%Mirando.visible = true
	%Mirando.play()
	%AgarrandoLamparita.visible = false
	
	
	%TimerPlayRie.timeout.connect(func():
		Sounds.play_ingeniero_rie()
		$TimerPlayPiensa.set_wait_time(randf_range(2.5,4))
	)
	$TimerPlayPiensa.timeout.connect(func():
		Sounds.play_ingeniero_piensa()
		$TimerPlayPiensa.set_wait_time(randf_range(2.5,4))
	)
	
	%AreaDetectoraDeLamparitas.body_entered.connect(func(lamparita):
		if(estado != Estado.LamparitaEnMano):
			lamparita_a_buscar = lamparita
			estado = Estado.BuscandoLamparita
			Sounds.play_ingeniero_pasos()
			%Mirando.animation = "corriendo"
	, CONNECT_ONE_SHOT)
	
	%AreaAgarradoraDeLamparitas.body_entered.connect(func(lamparita: Node2D):
		$TimerPlayPiensa.stop()
		Sounds.stop_ingeniero_pasos()
		$TimerPlayRie.start()
		estado = Estado.LamparitaEnMano
		mass = 5
		%Mirando.visible = false
		%AgarrandoLamparita.visible = true
		lamparita.queue_free()
		
		%AreaDeEnchufado.area_entered.connect(func(area_lampara_rota):
			estado = Estado.Enchufado
			var lampara_rota = area_lampara_rota.get_parent()
			global_position = lampara_rota.global_position + Vector2(-15, 160)
			global_rotation = lampara_rota.global_rotation
			await get_tree().physics_frame
			collision_layer = 0
			collision_mask = 0
			sleeping = true
			set_physics_process(false)
			
			var lamparita_nueva = $Node2D/AgarrandoLamparita/LamparitaNueva
			lamparita_nueva.visible = false
			lampara_rota.arreglar()
			
			%AgarrandoLamparita.play("electrocutándose")
			
			EstadoDePartida.se_gano("Ganaste... pero, ¡a qué costo!")
		, CONNECT_ONE_SHOT)
		
	, CONNECT_ONE_SHOT)
	
	%Saltar.timeout.connect(self.saltar)

func _physics_process(_delta):
	if(is_instance_valid(lamparita_a_buscar) and estado == Estado.BuscandoLamparita):
		var direction_x: float = sign(global_position.direction_to(lamparita_a_buscar.global_position).x)
		
		apply_central_force(mass * 800.0 * Vector2(direction_x, 0.5))

func saltar():
	if(estado == Estado.LamparitaEnMano):
		apply_impulse(Vector2(0, -700).rotated(rotation) * mass)
