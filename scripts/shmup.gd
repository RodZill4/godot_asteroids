extends Node2D

var root
var sky
var timer

const meteor_count = [ 2, 2, 2, 4 ]

func _ready():
	var root = get_tree().get_root()
	root.connect("size_changed", get_node("Sky"), "_resize")
	timer = Timer.new()
	add_child(timer)
	timer.connect("timeout", self, "create_foe")
	schedule_foe()

func schedule_foe():
	timer.set_wait_time(randf() * 2 + 3)
	timer.start()
	
func create_foe():
	var player_pos = get_node("Player").get_pos()
	var angle  = rand_range(-PI, PI)
	var direction  = Vector2(cos(angle), sin(angle))
	var pos = player_pos - 800.0 * direction
	var foe_choice = randi()%10
	if foe_choice < 5:
		var meteor_size = randi()%4
		var meteor_scene = load("res://scenes/meteor_b"+str(meteor_size)+"_"+str(randi()%meteor_count[meteor_size])+".scn")
		for i in range(0, 4-meteor_size):
			var meteor = meteor_scene.instance()
			add_child(meteor)
			meteor.init(pos, 50.0 * direction)
			pos += Vector2(randf(), randf()) * 50
			direction = (player_pos - pos).normalized()
	elif foe_choice < 8:
		var foe2_scene = preload("res://scenes/foe2.scn")
		var foe = foe2_scene.instance()
		add_child(foe)
		foe.set_pos(pos)
	else:
		var foe1_scene = preload("res://scenes/foe1.scn")
		for i in range(0, 4):
			var foe = foe1_scene.instance()
			add_child(foe)
			foe.set_pos(pos)
			pos += Vector2(50, 50)
	schedule_foe()

func _on_Game_resized():
	pass # replace with function body
