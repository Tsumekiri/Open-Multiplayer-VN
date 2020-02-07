extends PopulatedParentDropdown

func _ready():
	load_items()
	data_key = "character"
	child_data_key = "expression"

func load_items():
	populate(CharacterManager.get_character_list())
