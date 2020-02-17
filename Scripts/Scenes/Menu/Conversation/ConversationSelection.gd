extends OptionButton

func _ready():
	ConversationManager.connect("conversation_list_updated", self, "populate")

# Populates list by ConversationManager.conversation_list
func populate():
	clear()
	add_item("")
	
	for item in ConversationManager.get_conversation_list():
		add_item(item)
	
	var player = NetworkManager.get_player_data(NetworkManager.get_id())
	var conversation = player.get_data("conversation")
	
	select_item_name(conversation)

# Selects an item by text
func select_item_name(pName: String) -> void:
	for item in range(get_item_count()):
		if get_item_text(item) == pName:
			select(item)
			return
