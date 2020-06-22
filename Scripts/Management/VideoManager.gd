extends ThreadedResourceLoader

var video_list: Dictionary = {}
const ALLOWED_EXTENSIONS: Array = ["webm", "o"]

# Getter for the video list
func get_background_list() -> Dictionary:
	return video_list

# Getter for a specific video set
func get_background_set(set_name: String):
	if video_list.has(set_name):
		return video_list[set_name]
	return null

# Loads all characters present in the server folder
func _load_resources(_args) -> void:
	VNResourceLoader.load_vn_resources(FileManager.get_folder_path(FileManager.VIDEOS), self)
	
	# Add code to run after loading every background
	
	print("========== VIDEOS ==========")
	print(video_list)
	for video_set in video_list.values():
		print(video_set.get_vn_videos())
	
	_finish_loading()

# Called by the VNResourceLoader to load each folder
func load_resource(path: String) -> void:
	if cancel_loading:
		return
	
	var video_set: String = path.get_basename()
	video_list[video_set] = VideoSet.new(video_set, ALLOWED_EXTENSIONS)
	
	# Add code to run while loading each background folder