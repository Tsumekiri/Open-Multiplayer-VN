extends ConversationValueDropdown

func _ready():
	populate(BackgroundManager.get_background_list())
	select_current()
	
	conversation_name_node.connect("item_selected_name", self, "update_selection")

# Updates selection based on the selected current conversation
func update_selection(_conversation_name) -> void:
	select_current()
	emit_signal("updated_selection")

# Selects the player's current background in conversation
func select_current() -> void:
	var conversation = conversation_name_node.get_item_name()
	if conversation:
		var background_set = ConversationManager.get_conversation_data(conversation, "background_set")
		if background_set:
			select_item_name(background_set)
		else:
			select(0)
