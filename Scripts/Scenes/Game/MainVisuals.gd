extends Control

func _gui_input(event):
	if event is InputEventMouseButton:
			if event.button_index == BUTTON_LEFT and event.pressed:
				MessageManager.show_next_message()
			elif event.button_index == BUTTON_WHEEL_UP and event.pressed:
				MessageManager.show_previous_message()
