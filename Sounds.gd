extends Node

var ingeniero_index = 0
signal paren_todo

func play_musica():
	if not $Musica.is_playing():
		$Musica.play()

func play_spawn():
	$SpawnSfx.play_random()

func play_gallina():
	var stream = $GallinaSfx.get_children().pick_random()
	stream.set_pitch_scale(randf_range(0.85,1.7))
	stream.play()

func play_lamp_collision():
	$LampCollisionSfx.play_random()

func play_lamp_win():
	$LampWinSfx.play()

func stop_all_sounds():
	$LampWinSfx.stop()
	paren_todo.emit()
	$ShockSfx.stop()
	
	var streams = $GallinaSfx.get_children()
	for stream in streams:
		stream.stop()
	
	var streams2 = $VentiladorSfx.get_children()
	for stream in streams2:
		stream.stop()

func play_select_cosa():
	$SeleccionarSfx.play()

func play_elefante_pasos():
	$ElefantePasosSfx.play()
	
func play_elefante_revolea():
	$ElefanteRevoleaSfx.play()
	
	
func play_elefante_resonga():
	var stream = $ElefanteResongaSfx.get_children().pick_random()
	stream.set_pitch_scale(randf_range(0.88,1.4))
	stream.set_volume_db(randf_range(-12,-9))
	stream.play()

func play_ingeniero_piensa():
	ingeniero_index = ingeniero_index % 5
	var stream = $IngenieroPiensaSfx.get_children()[ingeniero_index]
	stream.play_random()
	stream.set_pitch_scale(randf_range(0.85,1.5))
	ingeniero_index+=1

func play_ingeniero_rie():
	ingeniero_index = ingeniero_index%5
	var stream = $IngenieroRieSfx.get_children()[ingeniero_index]
	stream.play_random()
	#stream.set_pitch_scale(randf_range(0.85,1.5))
	ingeniero_index+=1

func stop_ingeniero_pasos():
	$IngenieroCamina.stop()
	
func play_ingeniero_salta():
	$IngenieroSaltaSfx.play_random()
	
func play_ventilador():
	var stream = $VentiladorSfx.get_children().pick_random()
	stream.set_pitch_scale(randf_range(0.95,1.2))
	stream.play()
	
func play_shock():
	$ShockSfx.play()

func play_ingeniero_muere():
	$IngenieroMuere.play_random()
	
func play_ingeniero_rebota():
	$IngenieroRebotaSfx.play_random()
