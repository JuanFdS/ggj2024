class_name Ingeniero
extends RigidBody2D

var lamparita_a_buscar = null

enum Estado { Paveando, BuscandoLamparita, LamparitaEnMano, Enchufado }

var estado = Estado.Paveando

func _ready():
	%Mirando.visible = true
	%AgarrandoLamparita.visible = false
	%AreaDetectoraDeLamparitas.body_entered.connect(func(lamparita):
		lamparita_a_buscar = lamparita
		estado = Estado.BuscandoLamparita,
		CONNECT_ONE_SHOT
	)
	%AreaAgarradoraDeLamparitas.body_entered.connect(func(lamparita: Node2D):
		estado = Estado.LamparitaEnMano
		%Mirando.visible = false
		%AgarrandoLamparita.visible = true
		lamparita.queue_free(),
		CONNECT_ONE_SHOT
	)
	%AreaDeEnchufado.area_entered.connect(func(area_lampara_rota):
		estado = Estado.Enchufado
		var lampara_rota = area_lampara_rota.get_parent()
		global_position = lampara_rota.global_position - %PuntoDeEnchufado.position
		await get_tree().physics_frame
		collision_layer = 0
		collision_mask = 0
		sleeping = true
		set_physics_process(false)
		EstadoDelJuego.se_gano(),
		CONNECT_ONE_SHOT
	)
	%Saltar.timeout.connect(self.saltar)

func _physics_process(delta):
	if(is_instance_valid(lamparita_a_buscar) and estado == Estado.BuscandoLamparita):
		var direction_x: float = sign(global_position.direction_to(lamparita_a_buscar.global_position).x)
		
		apply_central_force(mass * 800.0 * Vector2(direction_x, 5.0))

func saltar():
	if(estado == Estado.LamparitaEnMano):
		apply_impulse(Vector2(0, -700).rotated(rotation) * mass)
