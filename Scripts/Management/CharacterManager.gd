extends Node

var characterList: Dictionary = {}
const ALLOWED_EXTENSIONS: Array = ["png"]

var thread: Thread = Thread.new()

# Starts loading on a separate thread
func load_threaded():
	thread.start(self, "_load_characters")

# Loads all characters present in the server folder
func _load_characters(args) -> void:
	VNResourceLoader.load_vn_resources(FileManager.get_folder_path(FileManager.CHARACTERS), self)
	
	# Add code to run after loading all characters
	
	print("========== CHARACTERS ==========")
	print(characterList)
	for character in characterList.values():
		print(character.get_vn_images())
	
	_finish_loading()

# Called by the VNResourceLoader to load each folder
func load_resource(path: String):
	var character: String = path.get_basename()
	characterList[character] = MultiVN.Character.new(character, ALLOWED_EXTENSIONS)
	
	# Add code to run while loading each character folder

# Sets thread to inactive after loading
func _finish_loading():
	thread.call_deferred("wait_to_finish")

# Called on exit
func _exit_tree():
	if (thread.is_active()):
		thread.wait_to_finish()