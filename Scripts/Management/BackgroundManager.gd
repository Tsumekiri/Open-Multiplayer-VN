extends Node

var background_list: Dictionary = {}
const ALLOWED_EXTENSIONS: Array = ["png", "bmp", "jpg"]

var thread: Thread = Thread.new()
var cancel_loading: bool = false

signal loading_complete_s

# Starts loading on a separate thread
func load_threaded() -> void:
	thread.start(self, "_load_backgrounds")

# Loads all characters present in the server folder
func _load_backgrounds(args) -> void:
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

# Sets thread to inactive after loading
func _finish_loading() -> void:
	thread.call_deferred("wait_to_finish")
	emit_signal("loading_complete_s")

# Called on exit
func _exit_tree():
	if thread.is_active():
		cancel_loading = true
		thread.wait_to_finish()
		print("Stopped loading backgrounds...")
