extends ConversationButton

func _ready():
	connect("pressed", self, "request_remove_conversation")

# Asks server to remove a conversation
func request_remove_conversation():
	var conversation_name = selection_node.get_item_name()
	
	if conversation_name != "":
		if not ConversationManager.conversation_exists(conversation_name):
			return
		
		if player_id != 1:
			ConversationManager.rpc_id(1, "process_remove_conversation", player_id, player_key, conversation_name)
		else:
			ConversationManager.process_remove_conversation(player_id, player_key, conversation_name)
