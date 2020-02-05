extends PopulatedChildDropdown

func _ready():
	data_key = "background"
	parent_data_key = "background_set"
	load_items()

func get_asset_data():
	dropdown_list = null
	var set_name = player.get_data("background_set")
	
	if not set_name.empty():
		var background = BackgroundManager.get_background_set(set_name)
		if background:
			dropdown_list = background.get_vn_images()
	return null
