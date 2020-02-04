extends PopulatedDropdown

func _ready():
	load_items()
	data_key = "background_set"

func load_items():
	populate(BackgroundManager.get_background_list())
