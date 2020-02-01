extends "res://Scripts/Scenes/Menu/Generic/PopulatedDropdown.gd"

func _ready():
	load_items()

func load_items():
	populate(CharacterManager.get_character_list())
