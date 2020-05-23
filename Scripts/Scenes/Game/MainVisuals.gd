extends Control

func _gui_input(event):
	if event.is_action_pressed("next_message"):
		MessageManager.show_next_message()
	elif event.is_action_pressed("show_log"):
		MessageManager.show_previous_message()
