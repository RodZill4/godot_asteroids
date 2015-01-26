
extends Panel

# member variables here, example:
var TitleMenu
var SettingsMenu
var Sounds
var Animations
var LeavingMenu
var ScreenResolution

func _ready():
	Sounds = get_node("Sounds")
	TitleMenu = get_node("TitleMenu")
	SettingsMenu = get_node("SettingsMenu")
	Animations = get_node("Animations")
	ScreenResolution = get_node("SettingsMenu/Center/GridContainer/ScreenResolution")
	TitleMenu.show()
	SettingsMenu.hide()
	ScreenResolution.clear()
	ScreenResolution.add_item("1600x1050")
	ScreenResolution.add_item("1024x768")
	ScreenResolution.add_item("800x600")


func _menu_Transition(from, to):
	var anim = Animation.new()
	var from_opacity = anim.add_track(0)
	var to_opacity = anim.add_track(0)
	anim.set_length(1.0)
	anim.track_set_path(from_opacity, NodePath(from.get_name() + ":visibility/opacity"))
	anim.track_set_interpolation_type(from_opacity, 1)
	anim.track_set_path(to_opacity, NodePath(to.get_name() + ":visibility/opacity"))
	anim.track_set_interpolation_type(to_opacity, 1)
	anim.track_insert_key(from_opacity, 0.0, 1.0)
	anim.track_insert_key(from_opacity, 1.0, 0.0)
	anim.value_track_set_continuous(from_opacity, true)
	anim.track_insert_key(to_opacity,   0.0, 0.0)
	anim.track_insert_key(to_opacity,   1.0, 1.0)
	anim.value_track_set_continuous(to_opacity, true)
	to.show()
	to.set_opacity(0)
	LeavingMenu = from
	Animations.add_animation("MenuTransition", anim)
	Animations.play("MenuTransition", -1, 2)
	Sounds.play("button")


func _on_StartButton_pressed():
	Sounds.play("button")
	get_node("/root/global").goto_scene("res://scenes/game.scn")


func _on_SettingsButton_pressed():
	_menu_Transition(TitleMenu, SettingsMenu)


func _on_ExitButton_pressed():
	Sounds.play("button")
	OS.get_main_loop().quit()


func _on_ExitSettingsButton_pressed():
	_menu_Transition(SettingsMenu, TitleMenu)


func _on_Animations_finished():
	LeavingMenu.hide()


func _on_OptionButton_item_selected( ID ):
	pass # replace with function body

