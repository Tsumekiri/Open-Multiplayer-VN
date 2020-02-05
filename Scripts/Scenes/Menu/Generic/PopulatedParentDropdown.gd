extends PopulatedDropdown
class_name PopulatedParentDropdown

var child_data_key: String
var player_id: int = NetworkManager.get_id()

func _ready():
	PlayerManager.connect("data_changed", self, "reset_child_data")

func reset_child_data(key, _value):
	if key == data_key:
		PlayerManager.request_change_data(player_id, child_data_key, "")
