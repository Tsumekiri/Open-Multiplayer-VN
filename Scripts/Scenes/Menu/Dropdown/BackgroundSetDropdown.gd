extends PopulatedParentDropdown

func _ready():
	data_key = "background_set"
	child_data_key = "background"
	
	load_items()

func load_items():
	populate(BackgroundManager.get_background_list(), "image")
	add_separator()
	populate(VideoManager.get_video_list(), "video")

# Emits custom signal for item_selected that includes its text
func emit_item_name_selected(id: int):
	var item_name: String = get_item_text(get_item_index(id))
	emit_signal("item_selected_name", item_name)

	if id > 0:
		if get_item_metadata(id) == "image":
			emit_signal("data_selected", NetworkManager.get_id(), "is_video", "false")
		else:
			emit_signal("data_selected", NetworkManager.get_id(), "is_video", "true")

	emit_signal("data_selected", NetworkManager.get_id(), data_key, item_name)
