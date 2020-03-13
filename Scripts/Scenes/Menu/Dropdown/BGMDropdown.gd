extends PopulatedChildDropdown

func _ready():
	data_key = "bgm"
	load_items()

func get_asset_data():
	dropdown_list = null
	var set_name = player.get_data("bgm_set")
	
	if not set_name.empty():
		var bgm_set = BGMManager.get_bgm_set(set_name)
		if bgm_set:
			dropdown_list = bgm_set.get_vn_audios()
	return null
