extends PopulatedChildDropdown

func _ready():
	data_key = "sfx"
	parent_data_key = "sfx_set"
	load_items()

func get_asset_data():
	dropdown_list = null
	var set_name = player.get_data("sfx_set")
	
	if not set_name.empty():
		var sfx_set = SFXManager.get_sfx_set(set_name)
		if sfx_set:
			dropdown_list = sfx_set.get_vn_audios()
	return null
