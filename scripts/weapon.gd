extends Node2D

export(bool)       var silent
export(int)        var projectile_count     = 1
export(float)      var spread_angle         = 0
export(String)     var projectile_name      = "laser"
export(Color,RGB)  var projectile_color     = Color(128, 128, 128)
export(float)      var projectile_speed     = 500
export(float)      var projectile_duration  = 1.5
export(float)      var projectile_damage    = 5

var projectile_scene
var sample_library = preload("res://sounds/game_sounds.res")
var sound

func _ready():
	projectile_scene = load("res://scenes/" + projectile_name + ".scn")
	if !silent:
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
	for i in range(0, projectile_count):
		var projectile = projectile_scene.instance()
		p.add_child(projectile)
		projectile.init(pos, rot + (randf() - 0.5) * spread_angle, projectile_color, projectile_speed, projectile_duration, projectile_damage, t, o)
	if !silent:
		sound.play("laser", 0)
