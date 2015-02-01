extends "shipbase.gd"

export(String) var target_name = ""
export(int)    var max_hp      = 1
export(int)    var loot        = 0
export(float)  var flee_angle  = PI

var speed
var target

var state = 0

const CHASE = 0
const FLEE  = 1

func _ready():
	team = 1
	target = get_parent().get_node(target_name)
	hp = max_hp

func _fixed_process(delta):
	var pos = get_pos()
	var rot = get_rot()
	var max_rot_speed = 1
	var speed = Vector2(0, -200).rotated(rot)
	var required_rot = 0.1
	
	if (target != null):
		var target_pos = target.get_pos()
		var target_distance = pos - target_pos
		target_distance = target_distance.length()
		# Turn to aim at the target
		required_rot = get_pos().angle_to_point(target_pos) - get_rot()
		if (state == CHASE):
			speed *= 2
			if target_distance < 20:
				state = FLEE
		elif target_distance > 800:
			state = CHASE
	
	# Move
	do_move(speed * delta)
	
	# Or at the opposite direction if fleeing
	if (state != CHASE):
		required_rot += flee_angle
	if (required_rot != 0):
		var required_rot_fix = 0
		if (required_rot > PI):
			required_rot_fix = floor((required_rot + PI) / (2*PI))
		elif (required_rot < -PI):
			required_rot_fix = ceil((required_rot - PI) / (2*PI))
		required_rot -= required_rot_fix * 2*PI
		if ((delta * max_rot_speed) >= abs(required_rot)):
			rot += required_rot
		else:
			if (required_rot > 0):
				rot += delta * max_rot_speed
			elif (required_rot < 0):
				rot -= delta * max_rot_speed
	set_rot(rot)
	

func destroy(o):
	var explosion_scene = preload("res://scenes/explosion.scn")
	var explosion = explosion_scene.instance()
	explosion.init(get_pos(), Vector2())
	get_parent().add_child(explosion)
	queue_free()
	var node = get_node_from_id(o)
	if (node != null):
		node.add_score(loot)

func add_score(v):
	pass
