extends ConversationButton

export(String) var player_position

func request_enter_or_leave_conversation():
	var player_data : PlayerData = NetworkManager.get_player_data(player_id)
	
	# Checks if player is already in this conversation
	var curr_conversation = player_data.get_data("conversation")
	if curr_conversation == conversation_data.get_name():
		# Checks  if player is already in this position
		var curr_position = player_data.get_data("position")
		if curr_position == player_position:
			# Requests leaving conversation
			ConversationManager.rpc_id(1, "process_leave_conversation",
					player_id, player_key, conversation_data.get_name(), player_position)
			return
	# Otherwise, asks to enter conversation in this position
	ConversationManager.rpc_id(1, "process_enter_conversation",
			player_id, player_key, conversation_data.get_name(), player_position)
