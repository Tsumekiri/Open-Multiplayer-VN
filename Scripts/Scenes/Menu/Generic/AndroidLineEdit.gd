extends LineEdit
class_name AndroidLineEdit

var screen_height = ProjectSettings.get_setting("display/window/size/height")
var actual_resolution = OS.get_window_size()
onready var ratio = screen_height / actual_resolution.y
onready var global_position = get_global_position()
var target_y

func _process(_delta):
	if !has_focus():
		if target_y == global_position.y:
			return
		else:
			target_y = global_position.y
			set_global_position(Vector2(global_position.x, target_y))
	elif has_focus():
		target_y = min(global_position.y, screen_height - get_size().y - (OS.get_virtual_keyboard_height() * ratio))
		set_global_position(Vector2(global_position.x, target_y))
