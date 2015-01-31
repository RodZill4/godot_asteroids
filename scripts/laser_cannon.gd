extends Node2D

export(Color) var laser_color
export(float) var laser_speed    = 500
export(float) var laser_duration = 1.5
export(float) var laser_damage   = 5

var laser_scene = preload("res://scenes/laser.scn")
var sample_library = preload("res://sounds/game_sounds.res")
var sound

func _ready():
	sound = SamplePlayer2D.new()
	add_child(sound)
	sound.set_sample_library(sample_library)
	sound.voice_set_volume_scale_db(0, -10)

func fire(p, t, o):
	var pos = get_pos()
	var rot = get_rot()
	var node = get_parent()
	while node != p:
		pos  = node.get_pos() + pos.rotated(node.get_rot())
		rot += node.get_rot()
		node = node.get_parent()
	var laser = laser_scene.instance()
	p.add_child(laser)
	laser.init(pos, rot, laser_color, laser_speed, laser_duration, laser_damage, t, o)
	sound.play("laser", 0)
