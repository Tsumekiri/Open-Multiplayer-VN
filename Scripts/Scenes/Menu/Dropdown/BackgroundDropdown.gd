extends PopulatedChildDropdown

func _ready():
	data_key = "background"
	load_items()

func get_asset_data():
	dropdown_list = null
	var set_name = player.get_data("background_set")
	var is_video = player.get_data("is_video")
	
	if not set_name.empty() and not is_video.empty():
		if is_video == "false":
			var background = BackgroundManager.get_background_set(set_name)
			if background:
				dropdown_list = background.get_vn_images()
		else:
			var video_set = VideoManager.get_video_set(set_name)
			if video_set:
				dropdown_list = video_set.get_vn_videos()
	return null
