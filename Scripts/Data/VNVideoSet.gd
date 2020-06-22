extends Resource
class_name VNVideoSet

var data : Dictionary = {
	"name": "",
	"vn_videos": {}
}

# Constructor
# Note that allowed_extensions must contain an array of lowercase strings
func setup(name: String, folder_path: String, allowed_extensions: Array):
	data.name = name
	
	if (folder_path == null):
		print("ERROR: ROOT directory not set! Could not create video folder for " + data.name)
	else:
		load_vn_videos(folder_path, allowed_extensions)

# Returns VNVideos for this set
func get_vn_videos():
	return data.vn_videos

# Simple getter for a specific VNVideo
func get_vn_video(name: String):
	if data.vn_videos.has(name):
		return data.vn_videos[name]
	return null

# Returns the number of VNVideos for this set
func get_vn_videos_size() -> int:
	return data.vn_videos.size()

# Checks that requested video exists
func has_vn_video(name: String) -> bool:
	return data.vn_videos.has(name)

# Loads all VNVideos available in a particular VNVideoSet folder
func load_vn_videos(folder_path: String, allowed_extensions: Array):
	var dir: Directory = Directory.new()
	if dir.open(folder_path) != OK:
		return
	
	dir.list_dir_begin()
	
	while true:
		var vn_video: String = dir.get_next()
		if vn_video == "":
			break
		
		if vn_video.get_extension().to_lower() in allowed_extensions:
			add_vn_video(vn_video, folder_path)
	
	dir.list_dir_end()

# Adds a VNVideo to the vn_videos attribute of the VNVideoSet
func add_vn_video(file: String, folder_path: String):
	data.vn_video[file.get_basename()] = VNVideo.new(file, folder_path)
