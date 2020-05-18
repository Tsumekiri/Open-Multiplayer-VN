extends Panel

export(String) var title setget set_title, get_title

signal visibility_s(show)

func set_title(pTitle: String):
	title = pTitle
	$Title.set_text(title)

func get_title():
	return title

func _on_IngameMenu_gui_input(event):
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT):
		emit_signal("visibility_s", false)
