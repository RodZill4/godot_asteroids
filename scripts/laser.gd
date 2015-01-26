extends KinematicBody2D

var speed
var life = 0
var damage
var sample_player
var sample_library = preload("res://sounds/game_sounds.res")
var sound
var team
var origin

func init(p, r, s, l, d, t, o):
	set_pos(p)
	set_rot(r)
	speed = Vector2(-sin(r) * s, -cos(r) * s)
	life = l
	damage = d
	team = t
	origin = o

func _ready():
	set_fixed_process(true)
	sound = SamplePlayer2D.new()
	add_child(sound)
	sound.set_sample_library(sample_library)
	sound.play("laser", 0)
	sound.voice_set_volume_scale_db(0, -10)
	
func _fixed_process(delta):
	life -= delta
	if (life < 0):
		queue_free()
	elif (damage <= 0):
		if (!sound.is_voice_active(0)):
			queue_free()
	else:
		var newpos = get_pos() + delta * speed
		move(delta * speed)
		if (is_colliding()):
			damage -= get_collider().damage(damage, team, origin)
			if (damage <= 0):
				if (!sound.is_voice_active(0)):
					queue_free()
				else:
					hide()
		set_pos(newpos)

func damage(d, t, o = Nil):
	return 0
