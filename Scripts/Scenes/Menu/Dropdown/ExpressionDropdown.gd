extends PopulatedChildDropdown

func _ready():
	data_key = "expression"
	load_items()

func get_asset_data():
	dropdown_list = null
	var set_name = player.get_data("character")
	
	if not set_name.empty():
		var character = CharacterManager.get_character(set_name)
		if character:
			dropdown_list = character.get_vn_images()
	return null
