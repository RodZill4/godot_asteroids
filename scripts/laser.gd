extends KinematicBody2D

var speed
var life = 0
var damage
var sample_player
var team
var origin

func init(p, r, c, s, l, d, t, o):
	set_pos(p)
	set_rot(r)
	speed = Vector2(-sin(r) * s, -cos(r) * s)
	get_node("Sprite").set_modulate(c)
	life = l
	damage = d
	team = t
	origin = o

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	life -= delta
	if (life < 0):
		queue_free()
	else:
		var newpos = get_pos() + delta * speed
		move(delta * speed)
		if (is_colliding()):
			damage -= get_collider().damage(damage, team, origin)
			if (damage <= 0):
				queue_free()
		set_pos(newpos)

func damage(d, t, o = Nil):
	return 0
