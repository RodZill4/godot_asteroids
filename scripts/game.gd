extends Control

func _ready():
	# Initalization here
	pass

func _on_Game_Over_pressed():
	get_node("/root/global").goto_scene("res://scenes/start.scn")
