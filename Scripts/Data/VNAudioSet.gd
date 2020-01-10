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
func load_vn_audio(path: String, allowedExtensions: Array):
	var dir: Directory = Directory.new()
	if (dir.open(path) != OK):
		return
	
	dir.list_dir_begin() != OK
	
	while true:
		var vnAudio: String = dir.get_next()
		if (vnAudio == ""):
			break
		
		if (vnAudio.get_extension().to_lower() in allowedExtensions):
			add_vn_audio(path)
	
	dir.list_dir_end()

# Adds a VNAudio to the vnAudio attribute of the VNAudioSet
func add_vn_audio(path: String):
	data.vnAudio[path.get_basename()] = MultiVN.VNAudio.new(data.name, path)