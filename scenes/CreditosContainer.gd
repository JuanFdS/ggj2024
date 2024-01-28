extends PanelContainer

var tween

func mostrar():
	tween = create_tween()
	show()
	$Control.get_children().map(func(child):
		child.modulate.a = 0.0
	)
	$Control.get_children().map(func(child):
		await tween.tween_property(child, "modulate:a", 1.0, 0.4).finished
	)

func _unhandled_input(event):
	if event is InputEventMouseButton:
		disappear()
	
	get_viewport().set_input_as_handled()

func disappear():
	if(is_instance_valid(tween)):
		tween.stop()
	hide()
