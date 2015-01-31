extends "objectbase.gd"

var weapons

func _ready():
	weapons = []
	for i in get_children():
		if i.get_name().begins_with("Weapon"):
			weapons.append(i)

func fire():
	for i in weapons:
		i.fire(get_parent(), team, self)

func damage(d, t, o = null):
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
