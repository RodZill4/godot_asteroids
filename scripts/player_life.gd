
extends ProgressBar

var player

func _ready():
	player = get_tree().get_root().get_node("Game/Universe/Player")
	player.set_hp_receiver(self)

func update_hp(hp, max_hp):
	set_min(0)
	set_max(max_hp)
	set_val(hp)

