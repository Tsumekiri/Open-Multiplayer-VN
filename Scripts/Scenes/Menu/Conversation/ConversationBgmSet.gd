extends ConversationValueDropdown

func _ready():
	populate(BGMManager.get_bgm_list())
	select_current()
	
	conversation_name_node.connect("item_selected_name", self, "update_selection")

func update_selection(_conversation_name) -> void:
	select_current()
	emit_signal("updated_selection")

# Selects the player's current background in conversation
func select_current() -> void:
	var conversation = conversation_name_node.get_item_name()
	if conversation:
		var bgm_set = ConversationManager.get_conversation_data(conversation, "bgm_set")
		if bgm_set:
			select_item_name(bgm_set)
		else:
			select(0)
