extends Resource

var data: Dictionary = {
	"name": "",
	"vnAudio": {}
}

# Constructor
func setup(name: String, folderPath: String, allowedExtensions: Array):
	data.name = name
	
	if (folderPath == null):
		print("ERROR: ROOT directory not set! Could not create character folder for " + data.name)
	else:
		load_vn_audio(folderPath, allowedExtensions)

# Loads all the audio available in the particular VNAudioSet folder
func load_vn_audio(folderPath: String, allowedExtensions: Array):
	var dir: Directory = Directory.new()
	if (dir.open(folderPath) != OK):
		return
	
	dir.list_dir_begin()
	
	while true:
		var vnAudio: String = dir.get_next()
		if (vnAudio == ""):
			break
		
		if (vnAudio.get_extension().to_lower() in allowedExtensions):
			add_vn_audio(vnAudio, folderPath)
	
	dir.list_dir_end()

# Adds a VNAudio to the vnAudio attribute of the VNAudioSet
func add_vn_audio(file: String, folderPath: String):
	data.vnAudio[file.get_basename()] = MultiVN.VNAudio.new(data.name, file, folderPath)

# Simple getter for VNAudio dictionary
func get_vn_audio_dict():
	return data.vnAudio