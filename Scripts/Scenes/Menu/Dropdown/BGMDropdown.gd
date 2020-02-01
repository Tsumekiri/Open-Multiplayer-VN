extends "res://Scripts/Scenes/Menu/Generic/PopulatedDropdown.gd"

func _ready():
	load_items()

func load_items():
	populate(BGMManager.get_bgm_list())
