extends Button
class_name ConversationButton

var player_id: int
var player_key: String
var conversation_data
var selection_node

export(NodePath) var conversation_selection

# Called when the node enters the scene tree for the first time.
func _ready():
	player_id = NetworkManager.get_id()
	player_key = NetworkManager.get_key()
	selection_node = get_node(conversation_selection)
	
	if "item_selected_name" in selection_node.get_signal_list():
		selection_node.connect("item_selected_name", self, "set_conversation_data")

# Setter for conversation name
func set_conversation_data(conversation_name: String) -> void:
	conversation_data = ConversationManager.get_conversation(conversation_name)
