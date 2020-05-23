extends LineEdit

export(NodePath) var send_button_path : NodePath

func _gui_input(event):
	if event.is_action_pressed("send_message"):
		if text.empty():
			MessageManager.show_next_message()
		else:
			send_message()

func send_message():
	var send_button : Button = get_node(send_button_path)
	if send_button:
		send_button.send()
