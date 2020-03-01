extends ConversationValueDropdown

export(NodePath) var parent_node_path
var parent_node

func _ready():
	repopulate(null, null, null)
	
	parent_node = get_node(parent_node_path)
	parent_node.connect("data_selected", self, "repopulate")
	
# Repopulates dropdown based on parent selection
func repopulate(_id, _key, _value):
	var background_list = get_background_list()
	populate(background_list)

# Attempts to get the background list based on the current selected conversation
func get_background_list():
	var conversation_name = conversation_name_node.get_item_name()
	if conversation_name:
		var background_set_name = ConversationManager.get_conversation_data(conversation_name, "background_set")
		if not background_set_name.empty():
			var background_set = BackgroundManager.get_background_set(background_set_name)
			if background_set:
				return background_set.get_vn_images()
	return {}

# Selects the player's current background in conversation
func select_current():
	var conversation = conversation_name_node.get_item_name()
	if conversation:
		var background_set = ConversationManager.get_conversation_data(conversation, "background_set")
		select_item_name(background_set)
