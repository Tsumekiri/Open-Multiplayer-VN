extends ConversationButton

func _ready():
	connect("button_pressed", self, "request_create_conversation")

# Asks server to create a new conversation
func request_create_conversation():
	if conversation_exists():
		return
	
	if player_id != 1:
		ConversationManager.rpc_id(1, "process_create_conversation", player_id,
				player_key, conversation_selection.get_text())
	else:
		ConversationManager.process_create_conversation(player_id,
				player_key, conversation_selection.get_text())

func conversation_exists() -> bool:
	if conversation_data != null:
		if (ConversationManager.conversation_exists(conversation_data.get_name()) or
				conversation_data.get_name() == null or
				conversation_data.get_name().empty() ):
			return true
	return false
