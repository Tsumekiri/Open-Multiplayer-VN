extends Node

var bgmList: Dictionary = {}
const ALLOWED_EXTENSIONS = ["ogg", "wav"]

var thread: Thread = Thread.new()
var cancelLoading: bool = false

signal loading_complete_s

# Starts loading on a separate thread
func load_threaded() -> void:
	thread.start(self, "_load_bgm")

# Loads all background music present in the server folder
func _load_bgm(args) -> void:
	VNResourceLoader.load_vn_resources(FileManager.get_folder_path(FileManager.BGM), self)
	
	# Add code to run after loading all sound effects
	
	print("========== BGM ==========")
	print(bgmList)
	for bgm in bgmList.values():
		print(bgm.get_vn_audio_dict())
	
	_finish_loading()

# Called by the VNResourceLoader to load each folder
func load_resource(path: String):
	var soundtrack: String = path.get_basename()
	bgmList[soundtrack] = MultiVN.BGM.new(soundtrack, ALLOWED_EXTENSIONS)
	
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
		print("Stopped loading BGM...")