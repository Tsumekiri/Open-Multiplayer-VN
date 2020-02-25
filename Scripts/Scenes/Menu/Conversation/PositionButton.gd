extends ConversationButton

export(String) var player_position

func _ready():
	connect("pressed", self, "request_enter_or_leave_conversation")
	connect("conversation_data_set", self, "update_button_text")
	ConversationManager.connect("conversation_list_updated", self, "update_button_text")

# Action, when button is pressed
func request_enter_or_leave_conversation():
	if selection_node.get_text() == "":
		PlayerManager.request_change_data(player_id, "position", player_position)
		return
	
	var player_data : PlayerData = NetworkManager.get_player_data(player_id)
	
	# Checks if player is already in this conversation
	if get_text() == player_data.get_data("user"):
		# Requests leaving conversation
		request_leave_conversation()
	elif conversation_data.get_name() != "":
		# Otherwise, asks to enter conversation in this position
		request_enter_conversation()
	else:
		request_change_position()

# Requests leaving a conversation to ConversationManager
func request_leave_conversation() -> void:
	if player_id != 1:
		ConversationManager.rpc_id(1, "process_leave_conversation",
				player_id, player_key, conversation_data.get_name(), player_position)
	else:
		ConversationManager.process_leave_conversation(player_id, player_key,
				conversation_data.get_name(), player_position)

# Requests entering a conversation to ConversationManager
func request_enter_conversation() -> void:
	if player_id != 1:
		ConversationManager.rpc_id(1, "process_enter_conversation",
				player_id, player_key, conversation_data.get_name(), player_position)
	else:
		ConversationManager.process_enter_conversation(player_id, player_key,
				conversation_data.get_name(), player_position)

# Requests changing position data to PlayerManager
func request_change_position() -> void:
	if player_id != 1:
		PlayerManager.request_change_data(player_id, "position", player_position)
	else:
		PlayerManager.process_change_data(player_key, player_id,
				"position", player_position)

# Updates button text according to selected conversation
func update_button_text() -> void:
	if conversation_data:
		var position_player = conversation_data.get_position(player_position)
		if position_player:
			set_text(position_player)
			return
	set_text(player_position)
