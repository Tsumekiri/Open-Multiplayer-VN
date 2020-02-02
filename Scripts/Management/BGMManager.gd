extends ThreadedResourceLoader

var bgm_list: Dictionary = {}
const ALLOWED_EXTENSIONS = ["ogg", "wav"]

# Getter for the bgm list
func get_bgm_list() -> Dictionary:
	return bgm_list

# Loads all background music present in the server folder
func _load_resources(args) -> void:
	VNResourceLoader.load_vn_resources(FileManager.get_folder_path(FileManager.BGM), self)
	
	# Add code to run after loading all sound effects
	
	print("========== BGM ==========")
	print(bgm_list)
	for bgm in bgm_list.values():
		print(bgm.get_vn_audio_dict())
	
	_finish_loading()

# Called by the VNResourceLoader to load each folder
func load_resource(path: String):
	if cancel_loading:
		return
	
	var soundtrack: String = path.get_basename()
	bgm_list[soundtrack] = BGM.new(soundtrack, ALLOWED_EXTENSIONS)
	
	# Add code to run after loading each sound effect folder
