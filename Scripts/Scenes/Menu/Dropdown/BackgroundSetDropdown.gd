extends PopulatedParentDropdown

func _ready():
	data_key = "background_set"
	child_data_key = "background"
	
	load_items()

func load_items():
	populate(BackgroundManager.get_background_list())
