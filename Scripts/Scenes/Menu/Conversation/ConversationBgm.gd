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
	populate(get_bgm_list())
	select_current()

# Updates current selection based on parent
func update_selection() -> void:
	repopulate(null, null, null)

# Attempts to get the background list based on the current selected conversation
func get_bgm_list() -> Dictionary:
	var conversation_name = conversation_name_node.get_item_name()
	if conversation_name:
		var bgm_set_name = ConversationManager.get_conversation_data(conversation_name, "bgm_set")
		if bgm_set_name and not bgm_set_name.empty():
			var bgm_set = BGMManager.get_bgm_set(bgm_set_name)
			if bgm_set:
				return bgm_set.get_vn_audios()
	return {}

# Selects the player's current background in conversation
func select_current() -> void:
	var conversation = conversation_name_node.get_item_name()
	if conversation:
		var bgm = ConversationManager.get_conversation_data(conversation, "bgm")
		if bgm:
			select_item_name(bgm)
		else:
			select(0)
