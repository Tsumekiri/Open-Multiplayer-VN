extends Node

var sfxList: Dictionary = {}
const ALLOWED_EXTENSIONS = ["ogg", "wav"]

var thread: Thread = Thread.new()

# Starts loading on a separate thread
func load_threaded() -> void:
	thread.start(self, "_load_sfx")

# Loads all sound effects present in the server folder
func _load_sfx(args) -> void:
	VNResourceLoader.load_vn_resources(FileManager.get_folder_path(FileManager.SFX), self)
	
	# Add code to run after loading all sound effects
	_finish_loading()

# Called by the VNResourceLoader to load each folder
func load_resource(path: String):
	var effect: String = path.get_basename()
	sfxList[effect] = MultiVN.SFX.new(effect, ALLOWED_EXTENSIONS)
	
	# Add code to run after loading each sound effect folder

# Sets thread to inactive after loading
func _finish_loading():
	thread.call_deferred("wait_to_finish")

# Called on exit
func _exit_tree():
	if (thread.is_active()):
		thread.wait_to_finish()