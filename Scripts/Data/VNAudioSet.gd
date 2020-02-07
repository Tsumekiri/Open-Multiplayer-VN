extends Resource
class_name VNAudioSet

var data: Dictionary = {
	"name": "",
	"vn_audio": {}
}

# Constructor
func setup(name: String, folder_path: String, allowed_extensions: Array):
	data.name = name
	
	if folder_path == null:
		print("ERROR: ROOT directory not set! Could not create character folder for " + data.name)
	else:
		load_vn_audio(folder_path, allowed_extensions)

# Loads all the audio available in the particular VNAudioSet folder
func load_vn_audio(folder_path: String, allowed_extensions: Array):
	var dir: Directory = Directory.new()
	if dir.open(folder_path) != OK:
		return
	
	dir.list_dir_begin()
	
	while true:
		var vn_audio: String = dir.get_next()
		if vn_audio == "":
			break
		
		if vn_audio.get_extension().to_lower() in allowed_extensions:
			add_vn_audio(vn_audio, folder_path)
	
	dir.list_dir_end()

# Adds a VNAudio to the vnAudio attribute of the VNAudioSet
func add_vn_audio(file: String, folder_path: String):
	data.vn_audio[file.get_basename()] = VNAudio.new(data.name, file, folder_path)

# Simple getter for VNAudio dictionary
func get_vn_audios():
	return data.vn_audio
