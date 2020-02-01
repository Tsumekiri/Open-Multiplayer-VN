extends "res://Scripts/Data/ThreadedLoader.gd"

var background_list: Dictionary = {}
const ALLOWED_EXTENSIONS: Array = ["png", "bmp", "jpg"]

# Getter for the background list
func get_background_list():
	return background_list

# Loads all characters present in the server folder
func _load_resources(args) -> void:
	VNResourceLoader.load_vn_resources(FileManager.get_folder_path(FileManager.BACKGROUNDS), self)
	
	# Add code to run after loading every background
	
	print("========== BACKGROUNDS ==========")
	print(background_list)
	for background in background_list.values():
		print(background.get_vn_images())
	
	_finish_loading()

# Called by the VNResourceLoader to load each folder
func load_resource(path: String):
	var background: String = path.get_basename()
	background_list[background] = MultiVN.Background.new(background, ALLOWED_EXTENSIONS)
	
	# Add code to run while loading each background folder
