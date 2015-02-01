extends Sprite

var physics_state
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
	set_modulate(c)
	life = l
	damage = d
	team = t
	origin = o
	physics_state = Physics2DServer.space_get_direct_state(get_world_2d().get_space())

func _ready():
	set_fixed_process(true)

func _fixed_process(delta):
	life -= delta
	if (life < 0):
		queue_free()
	else:
		var newpos = get_pos() + delta * speed
		var intersect = physics_state.intersect_ray(get_pos(), newpos)
		if !intersect.empty():
			damage -= intersect["collider"].damage(damage, team, origin)
			if (damage <= 0):
				queue_free()
		set_pos(newpos)
