extends OptionButton
class_name ConversationValueDropdown

export(String) var data_key
export(NodePath) var conversation_name_path

onready var player_key = NetworkManager.get_key()
onready var conversation_name_node = get_node(conversation_name_path)

signal item_selected_name(item_name)
signal data_selected(id, key, value)

func _ready():
	connect("item_selected", self, "emit_item_name_selected")
	connect("data_selected", self, "request_change_data")
	ConversationManager.connect("conversation_list_updated", self, "select_server_data")

# Populates items based on a dictionary
func populate(dictionary: Dictionary) -> void:
	clear()
	
	add_item("None")
	for item in dictionary:
		add_item(item)

# Requests to server a change in a conversation data
func request_change_data(id: int, key: String, value: String) -> void:
	if id != 1:
		ConversationManager.rpc_id(1, "process_change_conversation_data",
				id, NetworkManager.get_key(), conversation_name_node.get_item_name(), key, value)
	else:
		ConversationManager.process_change_conversation_data(id, NetworkManager.get_key(),
				conversation_name_node.get_item_name(), key, value)

# Emits custom signal for item_selected that includes its text
func emit_item_name_selected(id: int):
	var item_name: String = get_item_text(get_item_index(id))
	emit_signal("item_selected_name", item_name)
	emit_signal("data_selected", NetworkManager.get_id(), data_key, item_name)

# Selects an item by text, if item exists
func select_item_name(pName: String) -> void:
	for item in range(get_item_count()):
		if get_item_text(item) == pName:
			select(item)
			return

# Updates selected item based on key-value pair received from server data signal
func select_server_data() -> void:
	var target_conversation = conversation_name_node.get_item_name()
	if target_conversation:
		select_item_name(ConversationManager.get_conversation_data(target_conversation, data_key))
