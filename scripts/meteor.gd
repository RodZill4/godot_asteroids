extends "objectbase.gd"

var speed
var rotation
export(int) var size   = 1
export(int) var max_hp = 10

const meteor_count = [ 2, 2, 2, 4 ]

func init(p, s):
	set_pos(p)
	speed = s
	team = 2

func _ready():
	speed = Vector2()
	rotation = randf() - 0.5
	set_fixed_process(true)
	hp = max_hp

func destroy(o):
	# Create explosion
	var explosion_scene = preload("res://scenes/explosion.scn")
	var explosion = explosion_scene.instance()
	explosion.init(get_pos(), speed)
	get_parent().add_child(explosion)
	# Create 3 smaller meteors
	if (size > 0):
		var count = rand_range(1, 3)
		var angle = randf() * PI
		for i in range(count):
			var meteor_scene = load("res://scenes/meteor_b"+str(size-1)+"_"+str(randi()%meteor_count[size-1])+".scn")
			var meteor = meteor_scene.instance()
			var direction = Vector2(cos(angle), sin(angle))
			get_parent().add_child(meteor)
			meteor.init(get_pos() + direction * 10 * size, speed + (5 + randf() * 5) * direction)
			angle += 2 * PI / count
			angle += randf() * 0.3
	var node = get_node_from_id(o)
	if (node != null):
		node.add_score(100 * (4 - size))
	queue_free()

func _fixed_process(delta):
	set_rot(get_rot() + rotation * delta)
	do_move(delta * speed)

func damage(d, t, o = null):
	if (hp <= d):
		destroy(o)
		return hp
	else:
		hp -= d
		return d
