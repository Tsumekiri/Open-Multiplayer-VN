extends ConversationValueDropdown

export(NodePath) var parent_node_path
var parent_node

func _ready():
	repopulate(null, null, null)
	
	parent_node = get_node(parent_node_path)
	parent_node.connect("data_selected", self, "repopulate")
	parent_node.connect("updated_selection", self, "update_selection")
	
# Repopulates dropdown based on parent selection
func repopulate(_id, _key, _value) -> void:
	populate(get_background_list())
	select_current()

# Updates current selection based on parent
func update_selection() -> void:
	repopulate(null, null, null)

# Attempts to get the background list based on the current selected conversation
func get_background_list() -> Dictionary:
	var conversation_name = conversation_name_node.get_item_name()
	if conversation_name:
		var background_set_name = ConversationManager.get_conversation_data(conversation_name, "background_set")
		var is_video = ConversationManager.get_conversation_data(conversation_name, "is_video")
		if background_set_name and not background_set_name.empty() and is_video and not is_video.empty():
			if is_video == "false":
				var background_set = BackgroundManager.get_background_set(background_set_name)
				if background_set:
					return background_set.get_vn_images()
			else:
				var video_set = VideoManager.get_video_set(background_set_name)
				if video_set:
					return video_set.get_vn_videos()
	return {}

# Selects the player's current background in conversation
func select_current() -> void:
	var conversation = conversation_name_node.get_item_name()
	if conversation:
		var background = ConversationManager.get_conversation_data(conversation, "background")
		if background:
			select_item_name(background)
		else:
			select(0)
