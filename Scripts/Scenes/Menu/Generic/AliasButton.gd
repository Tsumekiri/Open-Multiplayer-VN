extends Button

export(NodePath) var alias_input : NodePath

const data_key : String = "alias"
var player_id : int = NetworkManager.get_id()

func _ready():
	connect("pressed", self, "change_alias")

func change_alias() -> void:
	var new_alias : String = get_node(alias_input).get_text()
	PlayerManager.request_change_data(player_id, data_key, new_alias)
