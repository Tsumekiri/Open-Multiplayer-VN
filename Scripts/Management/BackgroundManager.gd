extends Node

var backgroundList: Dictionary = {}
const ALLOWED_EXTENSIONS: Array = ["png", "bmp", "jpg"]

var thread: Thread = Thread.new()

# Starts loading on a separate thread
func load_threaded() -> void:
	thread.start(self, "_load_backgrounds")

# Loads all characters present in the server folder
func _load_backgrounds(args) -> void:
	VNResourceLoader.load_vn_resources(FileManager.get_folder_path(FileManager.BACKGROUNDS), self)
	
	# Add code to run after loading every background
	
	print("========== BACKGROUNDS ==========")
	print(backgroundList)
	for background in backgroundList.values():
		print(background.get_vn_images())
	
	_finish_loading()

# Called by the VNResourceLoader to load each folder
func load_resource(path: String):
	var background: String = path.get_basename()
	backgroundList[background] = MultiVN.Background.new(background, ALLOWED_EXTENSIONS)
	
	# Add code to run while loading each background folder

# Sets thread to inactive after loading
func _finish_loading() -> void:
	thread.call_deferred("wait_to_finish")

# Called on exit
func _exit_tree():
	if (thread.is_active()):
		thread.wait_to_finish()