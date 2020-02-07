extends PopulatedParentDropdown

func _ready():
	load_items()
	data_key = "sfx_set"
	child_data_key = "sfx"

func load_items():
	populate(SFXManager.get_sfx_list())
