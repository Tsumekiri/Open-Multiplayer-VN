extends "res://Scripts/Data/ThreadedLoader.gd"

var character_list: Dictionary = {}
const ALLOWED_EXTENSIONS: Array = ["png"]

# Getter for the character list
func get_character_list():
	return character_list

# Loads all characters present in the server folder
func _load_resources(args) -> void:
	VNResourceLoader.load_vn_resources(FileManager.get_folder_path(FileManager.CHARACTERS), self)
	
	# Add code to run after loading all characters
	
	print("========== CHARACTERS ==========")
	print(character_list)
	for character in character_list.values():
		print(character.get_vn_images())
	
	_finish_loading()

# Called by the VNResourceLoader to load each folder
func load_resource(path: String):
	var character: String = path.get_basename()
	character_list[character] = MultiVN.Character.new(character, ALLOWED_EXTENSIONS)
	
	# Add code to run while loading each character folder
