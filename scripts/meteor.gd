extends KinematicBody2D

var speed
var rotation
export(int) var size = 1
export(int) var hp   = 10

const meteor_count = [ 2, 2, 2, 4 ]

func init(p, s):
	set_pos(p)
	speed = s

func _ready():
	speed = Vector2()
	rotation = randf() - 0.5
	set_fixed_process(true)

func destroy():
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
			
	queue_free()
	

func _fixed_process(delta):
	var newpos = get_pos() + delta * speed
	set_rot(get_rot() + rotation * delta)
	move(delta * speed)
	if (is_colliding()):
		hp -= get_collider().damage(hp, 2)
		if (hp <= 0):
			destroy()
	set_pos(newpos)

func damage(d, t, o = null):
	if (hp <= d):
		destroy()
		if (o != null):
			print("Drop !")
		return hp
	else:
		hp -= d
		return d

