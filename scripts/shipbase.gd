extends "objectbase.gd"

var weapons

func _ready():
	weapons = []
	for i in get_children():
		if i.get_name().begins_with("Weapon"):
			weapons.append(i)

func fire():
	var id = get_instance_ID()
	for i in weapons:
		i.fire(get_parent(), team, id)

func damage(d, t, o = 0):
	if (t != team):
		if (hp <= d):
			set_hp(0)
			destroy(o)
			return hp
		else:
			set_hp(hp - d)
			return d
	else:
		return 0
