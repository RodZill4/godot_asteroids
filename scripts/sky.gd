
extends Polygon2D


func _ready():
	set_process(true)

func _process(delta):
	set_texture_offset(get_texture_offset() + Vector2(2, 5) * delta)

func _resize():
	print("resized")
