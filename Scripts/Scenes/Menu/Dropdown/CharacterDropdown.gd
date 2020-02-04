extends PopulatedDropdown

func _ready():
	load_items()
	data_key = "character"

func load_items():
	populate(CharacterManager.get_character_list())
