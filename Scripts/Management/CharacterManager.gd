extends Node

var characters: Dictionary = {}
const allowedExtensions: Array = ["png"]

# Loads all characters present in the server folder
func load_characters(args) -> void:
	VNResourceLoader.load_vn_images(FileManager.get_folder_path(FileManager.CHARACTERS), self)
	
	print(characters)
	for character in characters.values():
		print(character.get_vn_images())

func load_resource(path: String):
	var character: String = path.get_basename()
	characters[character] = MultiVN.Character.new(character, allowedExtensions)
