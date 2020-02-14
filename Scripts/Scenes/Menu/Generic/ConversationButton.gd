extends Button
class_name ConversationButton

var player_id: int
var player_key: String
var conversation_data

export(NodePath) var conversation_selection

# Called when the node enters the scene tree for the first time.
func _ready():
	player_id = NetworkManager.get_id()
	player_key = NetworkManager.get_key()
	
	if "item_selected_name" in conversation_selection.get_signal_list():
		conversation_selection.connect("item_selected_name", self, "set_conversation_data")

# Setter for conversation name
func set_conversation_data(conversation_name: String) -> void:
	conversation_data = ConversationManager.get_conversation(conversation_name)
