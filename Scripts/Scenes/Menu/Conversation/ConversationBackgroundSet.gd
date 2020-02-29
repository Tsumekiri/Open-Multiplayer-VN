extends ConversationValueDropdown

func _ready():
	populate(BackgroundManager.get_background_list())
	select_current()

# Selects the player's current background in conversation
func select_current():
	var conversation = conversation_name_node.get_item_name()
	if conversation:
		var background_set = ConversationManager.get_conversation_data(conversation, "background_set")
		select_item_name(background_set)
