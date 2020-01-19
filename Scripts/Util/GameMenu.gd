extends Panel

var menuTitle: String

func _on_Area2D_input_event(viewport, event, shape_idx):
	if (event is InputEventMouseButton and event.pressed and event.button_index == BUTTON_RIGHT):
		hide()

func _on_RightBar_open_menu(menu):
	if (menu == "Character" and not visible):
		show()
	else:
		hide()