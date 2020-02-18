extends OptionButton

func _ready():
	ConversationManager.connect("conversation_list_updated", self, "populate")
	connect("item_selected", self, "emit_item_name_selected")
	
	# Required to work with has_user_signal(signal). When that is not needed,
	# custom signals are declared on top, using the signal keyword
	add_user_signal("item_selected_name")

# Populates list by ConversationManager.conversation_list
func populate():
	var current_selection = get_item_name()
	
	clear()
	add_item("")
	
	for item in ConversationManager.get_conversation_list():
		add_item(item)
	
	var player = NetworkManager.get_player_data(NetworkManager.get_id())
	var conversation = player.get_data("conversation")
	
	if current_selection in ConversationManager.get_conversation_list() or current_selection.empty():
		select_item_name(current_selection)
	else:
		select_item_name(conversation)

# Gets selected item text
func get_item_name():
	if get_selected() != -1:
		return get_item_text(get_selected())
	else:
		return ""

# Selects an item by text
func select_item_name(pName: String) -> void:
	for item in range(get_item_count()):
		if get_item_text(item) == pName:
			select(item)
			return

# Emits custom signal for item_selected that includes its text
func emit_item_name_selected(id: int):
	var item_name: String = get_item_text(get_item_index(id))
	emit_signal("item_selected_name", item_name)
