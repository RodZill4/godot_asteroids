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
	timer.connect("timeout", self, "create_meteor")
	schedule_meteor()

func schedule_meteor():
	timer.set_wait_time(randf() * 2 + 1)
	timer.start()
	
func create_meteor():
	var player = get_node("Sky").get_pos()
	var angle  = rand_range(-PI, PI)
	var direction  = Vector2(cos(angle), sin(angle))
	var meteor_size = 3 #randi()%4
	var meteor_scene = load("res://scenes/meteor_b"+str(meteor_size)+"_"+str(randi()%meteor_count[meteor_size])+".scn")
	var meteor = meteor_scene.instance()
	add_child(meteor)
	meteor.init(player - 400.0 * direction, 50.0 * direction)
	schedule_meteor()