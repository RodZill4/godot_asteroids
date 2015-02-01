extends KinematicBody2D

var hp
var team
var origin

func _ready():
	set_fixed_process(true)

func do_move(v):
	var newpos = get_pos() + v
	move(v)
	if (is_colliding()):
		set_hp(hp - get_collider().damage(hp, team, origin))
	set_pos(newpos)

func set_hp(x):
	hp = x
	if (hp <= 0):
		hp = 0

func damage(d, t, o = null):
	return 0
	
func get_node_from_id(id):
	if (id == 0):
		return null
	else:
		var p = get_parent()
		for n in p.get_children():
			if (id == n.get_instance_ID()):
				return n
	return null
