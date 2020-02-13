extends Button
class_name ConversationButton

var player_id: int
var player_key: String
var conversation_name: String

export(NodePath) var conversation_selection

# Called when the node enters the scene tree for the first time.
func _ready():
	player_id = NetworkManager.get_id()
	player_key = NetworkManager.get_key()
	
	conversation_selection.connect("item_selected_name", self, "set_conversation_name")

# Setter for conversation name
func set_conversation_name(new_conversation_name: String) -> void:
	conversation_name = new_conversation_name
