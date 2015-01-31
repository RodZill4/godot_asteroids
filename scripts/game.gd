
extends EmptyControl

# member variables here, example:
# var a=2
# var b="textvar"

func _ready():
	# Initalization here
	pass

func _on_Game_Over_pressed():
	get_node("/root/global").goto_scene("res://scenes/start.scn")
