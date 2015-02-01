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
	randomize()

func schedule_foe():
	timer.set_wait_time(randf() * 2 + 3)
	timer.start()
	
func create_foe():
	print(get_child_count())
	if get_child_count() < 150:
		var player = get_node("Player")
		var player_pos = player.get_pos()
		var foe_choice = randi()%10
		var count = 1 + player.score / 100000 + (randi() % (1 + ((player.score % 100000) / 20000)))
		for j in range(0,count):
			var angle  = rand_range(-PI, PI)
			var direction = Vector2(cos(angle), sin(angle))
			var pos = player_pos - 1500.0 * direction
			if foe_choice < 2:
				var meteor_size = randi()%4
				var meteor_scene = load("res://scenes/meteor_b"+str(meteor_size)+"_"+str(randi()%meteor_count[meteor_size])+".scn")
				for i in range(0, 4-meteor_size):
					var meteor = meteor_scene.instance()
					add_child(meteor)
					meteor.init(pos, 50.0 * direction)
					pos += Vector2(randf(), randf()) * 50
					direction = (player_pos - pos).normalized()
			elif foe_choice < 4:
				var foe2_scene = preload("res://scenes/foe2.scn")
				var foe = foe2_scene.instance()
				add_child(foe)
				foe.set_pos(pos)
			elif foe_choice < 6:
				var foe2_scene = preload("res://scenes/foe3.scn")
				var foe = foe2_scene.instance()
				add_child(foe)
				foe.set_pos(pos)
			elif foe_choice < 8:
				var kamikaze_scene = preload("res://scenes/kamikaze1.scn")
				var foe = kamikaze_scene.instance()
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
