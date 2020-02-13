extends ConversationButton

# Asks server to create a new conversation
func request_create_conversation():
	if (ConversationManager.conversation_exists(conversation_name) or
			conversation_name == null or
			conversation_name.empty()):
		return
	
	if player_id != 1:
		ConversationManager.rpc_id(1, "process_create_conversation", player_id, player_key, conversation_name)
	else:
		ConversationManager.process_create_conversation(player_id, player_key, conversation_name)
