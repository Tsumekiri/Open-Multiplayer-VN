extends CheckBox

const data_key : String = "flip"
var player_id : int = NetworkManager.get_id()

func _ready():
	connect("pressed", self, "change_flip")

func change_flip() -> void:
	var target_flip : String = String(is_pressed())
	PlayerManager.request_change_data(player_id, data_key, target_flip)
