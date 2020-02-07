extends PopulatedParentDropdown

func _ready():
	load_items()
	data_key = "bgm_set"
	child_data_key = "bgm"

func load_items():
	populate(BGMManager.get_bgm_list())
