extends Resource

var data: Dictionary = {
	"audioSet": "",
	"name": "",
	"loop": false,
	"type": ""
}

func _init(audioSet: String, file: String, folderPath: String):
	data.audioSet = audioSet
	data.name = file.get_basename()
	data.audio = import_audio(get_audio_path(file, folderPath))
	data.type = file.get_extension().to_lower()

# Loads a PoolByteArray from the audio file, for use with either
# an AudioStreamOGGVorbis or an AudioStreamSample
func load_audio_bytes(path: String):
	var file: File = File.new()
	if (file.open(path, File.READ) != OK):
		return null
	
	var bytes: PoolByteArray = file.get_buffer(file.get_len())
	file.close()
	
	return bytes

# Imports either a wav audio file or an ogg audio file
func import_audio(path: String):
	var bytes = load_audio_bytes(path)
	var stream
	
	if (path.get_extension().to_lower() == "ogg"):
		stream = AudioStreamOGGVorbis.new()
	elif (path.get_extension().to_lower() == "wav"):
		stream = AudioStreamSample.new()
	
	stream.set_data(bytes)
	return stream

# Sets the loop mode for this audio
func set_loop(mode: bool) -> void:
	data.loop = mode
	if (data.type == "ogg"):
		data.audio.set_loop(mode)
	elif (data.type == "wav"):
		if (mode):
			data.audio.set_loop_mode(AudioStreamSample.LOOP_FORWARD)
		else:
			data.audio.set_loop_mode(AudioStreamSample.LOOP_DISABLED)

func get_audio_path(file: String, folderPath: String):
	return folderPath + file