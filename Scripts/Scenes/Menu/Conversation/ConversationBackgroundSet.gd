extends ConversationValueDropdown

func _ready():
	populate(BackgroundManager.get_background_list(), "image")
	add_separator()
	add_dictionary(VideoManager.get_video_list(), "video", false)

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

# Emits custom signal for item_selected that includes its text
func emit_item_name_selected(id: int) -> void:
	var item_name: String = get_item_text(get_item_index(id))
	emit_signal("item_selected_name", item_name)

	if id > 0:
		if get_item_metadata(id) == "image":
			emit_signal("data_selected", NetworkManager.get_id(), "is_video", "false")
		else:
			emit_signal("data_selected", NetworkManager.get_id(), "is_video", "true")

	emit_signal("data_selected", NetworkManager.get_id(), data_key, item_name)

# Sets the conversation's is_video property to the apropriate value, so that the video or image appears on-screen
func is_selected_video(idx: int) -> void:
	if idx > 0:
		if get_item_metadata(idx) == "image":
			emit_signal("data_selected", NetworkManager.get_id(), "is_video", "false")
		else:
			emit_signal("data_selected", NetworkManager.get_id(), "is_video", "true")