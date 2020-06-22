extends Resource
class_name VNAudio

var data: Dictionary = {
	"audio_set": "",
	"name": "",
	"loop": false,
	"audio": null,
	"type": ""
}

func _init(audio_set: String, file: String, folder_path: String):
	data.audio_set = audio_set
	data.name = file.get_basename()
	data.audio = import_audio(get_audio_path(file, folder_path))
	data.type = file.get_extension().to_lower()

# Loads a PoolByteArray from the audio file, for use with either
# an AudioStreamOGGVorbis or an AudioStreamSample
func load_audio_bytes(path: String):
	var file: File = File.new()
	if file.open(path, File.READ) != OK:
		return null
	
	var bytes: PoolByteArray = file.get_buffer(file.get_len())
	file.close()
	
	return bytes

# Imports either a wav audio file or an ogg audio file
func import_audio(path: String):
	var bytes = load_audio_bytes(path)
	var stream
	
	if path.get_extension().to_lower() == "ogg":
		stream = AudioStreamOGGVorbis.new()
	elif path.get_extension().to_lower() == "wav":
		stream = AudioStreamSample.new()
	
	stream.set_data(bytes)
	return stream

# Sets the loop mode for this audio
func set_loop(mode: bool) -> void:
	data.loop = mode
	if data.type == "ogg":
		data.audio.set_loop(mode)
	elif data.type == "wav":
		if mode:
			data.audio.set_loop_mode(AudioStreamSample.LOOP_FORWARD)
		else:
			data.audio.set_loop_mode(AudioStreamSample.LOOP_DISABLED)

# Gets the full path to the resource
func get_audio_path(file: String, folder_path: String):
	return folder_path + file

# Returns audio stream
func get_audio():
	return data.audio
