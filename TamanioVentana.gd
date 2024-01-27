extends Node

@onready var tamanio_original: Vector2 = get_viewport().size
	
func escala_del_viewport() -> Vector2:
	return tamanio_original / Vector2(get_viewport().size)
