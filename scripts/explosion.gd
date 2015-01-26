extends Particles2D

var speed

func init(p, s):
	set_pos(p)
	speed = s

func _ready():
#	Play explosion sound (no, in fact this is not a good idea...)
#	var sample_library = preload("res://sounds/game_sounds.res")
#	var sound = SamplePlayer2D.new()
#	add_child(sound)
#	sound.set_sample_library(sample_library)
#	sound.play("explosion", 0)
#	sound.voice_set_volume_scale_db(0, strength - 15)
	var timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "queue_free")
	timer.set_wait_time(2)
	timer.start()
	set_fixed_process(true)

func _fixed_process(delta):
	set_pos(get_pos() + delta * speed)
