
extends Polygon2D

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	set_process(true)

func _process(delta):
	var t = get_global_transform()
	var points = get_polygon()
	var uvs = []
	for p in points:
		uvs.append(t.xform(p))
	set_uv(uvs)
