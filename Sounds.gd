extends Node

func play_spawn():
	$SpawnSfx.play_random()

func play_gallina():
	var stream = $GallinaSfx.get_children().pick_random()
	stream.set_pitch_scale(randf_range(0.85,1.5))
	stream.play()

func play_lamp_collision():
	$LampCollisionSfx.play_random()

func play_lamp_win():
	pass

func stop_all_sounds():
	$LampWinSfx.stop()
	var streams = $GallinaSfx.get_children()
	for stream in streams:
		stream.stop()
