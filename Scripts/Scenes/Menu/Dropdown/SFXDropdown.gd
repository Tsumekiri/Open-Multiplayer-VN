extends PopulatedDropdown

func _ready():
	load_items()
	data_key = "sfx_set"

func load_items():
	populate(SFXManager.get_sfx_list())
