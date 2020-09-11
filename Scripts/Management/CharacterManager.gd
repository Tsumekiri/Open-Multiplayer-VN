extends ThreadedResourceLoader

var character_list: Dictionary = {}
const ALLOWED_EXTENSIONS: Array = ["png"]

# Getter for the character list
func get_character_list() -> Dictionary:
	return character_list

# Getter for specific characters
func get_character(target: String):
	if target in character_list:
		return character_list.get(target)
	return null

# Loads all characters present in the server folder
func _load_resources(_args) -> void:
	VNResourceLoader.load_vn_resources(FileManager.get_folder_path(FileManager.CHARACTERS), self)
	
	# Add code to run after loading all characters
	
	#print("========== CHARACTERS ==========")
	#print(character_list)
	#for character in character_list.values():
	#	print(character.get_vn_images())
	
	_finish_loading()

# Called by the VNResourceLoader to load each folder
func load_resource(path: String):
	if cancel_loading:
		return
	
	var character: String = path.get_basename()
	character_list[character] = Character.new(character, ALLOWED_EXTENSIONS)
	
	# Add code to run while loading each character folder
