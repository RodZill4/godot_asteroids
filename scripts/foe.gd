extends "shipbase.gd"

export(String) var target_name        = ""
export(int)    var max_hp             = 1
export(float)  var fire_rate          = 1
export(int)    var loot               = 0
export(float)  var rot_speed          = 4
export(float)  var fire_distance      = 600
export(float)  var chase_distance     = 800
export(float)  var chase_speed        = 200
export(float)  var flee_distance      = 200
export(float)  var flee_speed         = 200
export(float)  var flee_angle         = 3.1416
export(bool)   var fire_while_fleeing = false

var speed
var target

var state = 0

const CHASE = 0
const FLEE  = 1

var time_since_last_fire = 0

func _ready():
	team = 1
	target = get_parent().get_node(target_name)
	hp = max_hp

func _fixed_process(delta):
	var pos           = get_pos()
	var rot           = get_rot()
	var required_rot  = 0.1
	var current_speed = chase_speed
	if (target != null):
		var target_pos = target.get_pos()
		var target_distance = pos - target_pos
		target_distance = target_distance.length()
		# Turn to aim at the target
		required_rot = get_pos().angle_to_point(target_pos) - get_rot()
		# Change behaviour if needed
		if (state == CHASE):
			if target_distance < flee_distance:
				state = FLEE
		elif target_distance > chase_distance:
			state = CHASE
		# Fix target angle and speed depending on bevaiour
		if (state == FLEE):
			current_speed = flee_speed
			required_rot += flee_angle
		# Fixing target angle
		var required_rot_fix = 0
		if (required_rot > PI):
			required_rot_fix = floor((required_rot + PI) / (2*PI))
		elif (required_rot < -PI):
			required_rot_fix = ceil((required_rot - PI) / (2*PI))
		required_rot -= required_rot_fix * 2*PI
		# Fire
		time_since_last_fire += delta
		if abs(required_rot) < 0.3 && time_since_last_fire > fire_rate && target_distance < fire_distance && fire_while_fleeing == (state == FLEE):
			time_since_last_fire = 0
			fire()
	# Move
	do_move(Vector2(0, -current_speed).rotated(rot) * delta)
	# Or at the opposite direction if fleeing
	if (required_rot != 0):
		if ((delta * rot_speed) >= abs(required_rot)):
			rot += required_rot
		else:
			if (required_rot > 0):
				rot += delta * rot_speed
			elif (required_rot < 0):
				rot -= delta * rot_speed
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
