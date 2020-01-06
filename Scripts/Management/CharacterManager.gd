extends Node

var characters: Dictionary = {}

# Loads all characters present in the server folder
func load_characters() -> void:
	var dir: Directory = Directory.new()
	
	dir.open(FileManager.get_folder_path(FileManager.CHARACTERS))
	dir.list_dir_begin()
	
	while true:
		var characterFolder = dir.get_next()
		if (characterFolder == ""):
			break
		elif (not characterFolder.begins_with(".") and dir.current_is_dir()):
			var character: String = characterFolder.get_basename()
			characters[character] = MultiVN.Character.new(character)
	
	dir.list_dir_end()
	
	# DEBUG:
	print(characters)
