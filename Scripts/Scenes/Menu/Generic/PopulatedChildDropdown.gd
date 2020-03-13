extends PopulatedDropdown
class_name PopulatedChildDropdown

var dropdown_list
var player: PlayerData = NetworkManager.get_player_data(NetworkManager.get_id())

func _ready():
	player = NetworkManager.get_player_data(NetworkManager.get_id())
	PlayerManager.connect("data_changed", self, "reload_items_on_change")

func reload_items_on_change(key, _value):
	if key == data_key:
		load_items()

func load_items():
	clear()
	get_asset_data()
	
	if dropdown_list != null:
		populate(dropdown_list)
		var selected_item = player.get_data(data_key)
		
		if dropdown_list.has(selected_item) and not selected_item.empty():
			select_item_name(selected_item)

func get_asset_data():
	pass
