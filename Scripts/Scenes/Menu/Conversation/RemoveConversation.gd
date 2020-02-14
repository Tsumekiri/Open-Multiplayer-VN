extends ConversationButton

func _ready():
	connect("button_pressed", self, "request_remove_conversation")

# Asks server to remove a conversation
func request_remove_conversation():
	if conversation_data != null:
		var conversation_name = conversation_data.get_name()
		if not ConversationManager.conversation_exists(conversation_name):
			return
		
		if player_id != 1:
			ConversationManager.rpc_id(1, "process_remove_conversation", player_id, player_key, conversation_name)
		else:
			ConversationManager.process_remove_conversation(player_id, player_key, conversation_name)
