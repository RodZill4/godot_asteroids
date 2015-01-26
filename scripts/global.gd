extends Node

var current_scene = null
var music_player
var music

func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	music_player = StreamPlayer.new()
	add_child(music_player)
	music = ResourceLoader.load("music/light_latt.ogg")
	music_player.set_stream(music)
	music_player.set_loop(true)
	music_player.play()


func goto_scene(scene):
	# remove current scene from root and enqueue it for deletion
	# (when deleted, it will be removed)
	current_scene.queue_free()
	# load and add new scene to root
	var s = ResourceLoader.load(scene)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
