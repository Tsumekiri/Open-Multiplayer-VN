extends ConversationButton

func _ready():
	connect("pressed", self, "request_create_conversation")

# Asks server to create a new conversation
func request_create_conversation():
	if conversation_exists():
		return
	
	if player_id != 1:
		ConversationManager.rpc_id(1, "process_create_conversation", player_id,
				player_key, selection_node.get_text())
	else:
		ConversationManager.process_create_conversation(player_id,
				player_key, selection_node.get_text())

# Checks that a conversation is currently selected and exists on manager
func conversation_exists() -> bool:
	if conversation_data != null:
		if (ConversationManager.conversation_exists(conversation_data.get_name()) or
				conversation_data.get_name() == null or
				conversation_data.get_name().empty() ):
			return true
	return false
