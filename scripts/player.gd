extends KinematicBody2D

export(float) var max_forward_speed  = 100
export(float) var max_backward_speed = 50
export(float) var max_sideward_speed = 70
export(float) var max_rot_speed      = 3
export(float) var reload_time        = 0.1
export(float) var max_hp             = 500

var hp
var team = 1

var hp_receiver = null

var time_since_last_fire = 0

func _ready():
	set_fixed_process(true)
	hp = max_hp

func set_hp_receiver(r):
	hp_receiver = r
	hp_receiver.update_hp(hp, max_hp)
	

func _fixed_process(delta):
	var pos = get_pos()
	var rot = get_rot()
	var speed = Vector2(0, 0)
	
	# Move
	if Input.is_action_pressed("ui_left"):
		speed.x -= 1
	if Input.is_action_pressed("ui_right"):
		speed.x += 1
	if Input.is_action_pressed("ui_up"):
		speed.y -= 1
	if Input.is_action_pressed("ui_down"):
		speed.y += 1
	speed = speed.normalized()
	var scalar_speed = 1000
	var projected_speed = speed.rotated(-rot)
	if (projected_speed.y > 0):
		scalar_speed = max_backward_speed / projected_speed.y
	elif (projected_speed.y < 0):
		scalar_speed = -max_forward_speed / projected_speed.y
	if (scalar_speed > max_sideward_speed / abs(projected_speed.x)):
		scalar_speed = max_sideward_speed / abs(projected_speed.x)
	set_pos(pos + speed.normalized() * scalar_speed * delta)
	
	# Turn to aim at the mouse pointer
	var required_rot = get_global_pos().angle_to_point(Input.get_mouse_pos()) - get_rot()
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
	
	# Fire
	time_since_last_fire += delta
	if Input.is_action_pressed("player_fire") && time_since_last_fire > reload_time:
		time_since_last_fire = 0
		var rot = get_rot()
		var laser_scene = preload("res://scenes/laser.scn")
		var laser = laser_scene.instance()
		get_parent().add_child(laser)
		laser.init(get_pos() + 30 * Vector2(-sin(rot), -cos(rot)), rot, 300, 1.3, 3, team, self)

func damage(d, t, o = Nil):
	if (t != team):
		if (hp <= d):
			var explosion_scene = preload("res://scenes/explosion.scn")
			var explosion = explosion_scene.instance()
			explosion.init(get_pos(), Vector2())
			get_parent().add_child(explosion)
			queue_free()
			if (hp_receiver != null):
				hp_receiver.update_hp(0, max_hp)
			return hp
		else:
			hp -= d
			if (hp_receiver != null):
				hp_receiver.update_hp(hp, max_hp)
			return d
	else:
		return 0
