extends PopulatedDropdown

func _ready():
	load_items()
	data_key = "bgm_set"

func load_items():
	populate(BGMManager.get_bgm_list())
