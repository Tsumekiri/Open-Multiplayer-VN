extends Resource

var data: Dictionary = {
	"name": "",
	"vnAudio": {}
}

# Constructor
func setup(name: String, folderPath: String):
	data.name = name
	
	if (folderPath == null):
		print("ERROR: ROOT directory not set! Could not create character folder for " + data.name)
	else:
		load_vn_audio()

# Loads all the audio available in the particular VNAudioSet folder
func load_vn_audio():
	var regex = RegEx.new()
	
	