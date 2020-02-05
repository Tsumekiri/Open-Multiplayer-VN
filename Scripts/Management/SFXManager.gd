extends ThreadedResourceLoader

var sfx_list: Dictionary = {}
const ALLOWED_EXTENSIONS = ["ogg", "wav"]

# Getter for the sfx list
func get_sfx_list() -> Dictionary:
	return sfx_list

# Loads all sound effects present in the server folder
func _load_resources(_args) -> void:
	VNResourceLoader.load_vn_resources(FileManager.get_folder_path(FileManager.SFX), self)
	
	# Add code to run after loading all sound effects
	
	print("========== SFX ==========")
	print(sfx_list)
	for sfx in sfx_list.values():
		print(sfx.get_vn_audio_dict())
	
	_finish_loading()

# Called by the VNResourceLoader to load each folder
func load_resource(path: String):
	if cancel_loading:
		return
	
	var effect: String = path.get_basename()
	sfx_list[effect] = SFX.new(effect, ALLOWED_EXTENSIONS)
	
	# Add code to run after loading each sound effect folder
