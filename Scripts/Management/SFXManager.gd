extends Node

var sfxList: Dictionary = {}
const ALLOWED_EXTENSIONS = ["ogg", "wav"]

var thread: Thread = Thread.new()
var cancelLoading: bool = false

signal loading_complete_s

# Starts loading on a separate thread
func load_threaded() -> void:
	thread.start(self, "_load_sfx")

# Loads all sound effects present in the server folder
func _load_sfx(args) -> void:
	VNResourceLoader.load_vn_resources(FileManager.get_folder_path(FileManager.SFX), self)
	
	# Add code to run after loading all sound effects
	
	print("========== SFX ==========")
	print(sfxList)
	for sfx in sfxList.values():
		print(sfx.get_vn_audio_dict())
	
	_finish_loading()

# Called by the VNResourceLoader to load each folder
func load_resource(path: String):
	if (cancelLoading):
		return
	
	var effect: String = path.get_basename()
	sfxList[effect] = MultiVN.SFX.new(effect, ALLOWED_EXTENSIONS)
	
	# Add code to run after loading each sound effect folder

# Sets thread to inactive after loading
func _finish_loading():
	thread.call_deferred("wait_to_finish")
	emit_signal("loading_complete_s")

# Called on exit
func _exit_tree():
	if (thread.is_active()):
		cancelLoading = true
		thread.wait_to_finish()
		print("Stopped loading SFX...")