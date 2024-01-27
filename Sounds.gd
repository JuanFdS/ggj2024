extends Node

func play_spawn():
	$SpawnSfx.play_random()

func play_gallina():
	$GallinaSfx.set_pitch_scale(randi_range(1,10))
	$GallinaSfx.play_random()
