extends AudioStreamPlayer

export(String, "BGM", "SFX") var audio_type = "BGM"

func _ready():
	MessageManager.connect("message_received", self, "receive_message")

func receive_message(data) -> void:
	if not data is Dictionary:
		return
	
	if audio_type == "BGM" and data.bgm is Dictionary:
		load_bgm(data.bgm)
	
	elif audio_type == "SFX" and data.sfx is Dictionary:
		load_sfx(data.sfx)

func load_bgm(data: Dictionary) -> void:
	if not "bgm_set" in data or not "bgm" in data:
		return
	
	var bgm_set = BGMManager.get_bgm_set(data.bgm_set)
	if bgm_set and bgm_set is VNAudioSet:
		var audio_stream = bgm_set.get_vn_audio(data.bgm)
		if audio_stream and !self.get_stream() or (audio_stream != self.get_stream() or !self.is_playing()):
			self.set_stream(audio_stream)
			self.play()
	
	if (data.bgm_set.empty() or data.bgm_set == "None" or data.bgm.empty() or data.bgm == "None"):
		self.stop()
	

func load_sfx(data: Dictionary) -> void:
	if not "sfx_set" in data or not "sfx" in data:
		return
	
	var sfx_set = SFXManager.get_sfx_set(data.sfx_set)
	if sfx_set and sfx_set is VNAudioSet:
		var audio_stream = sfx_set.get_vn_audio(data.sfx)
		if audio_stream and !self.get_stream() or (audio_stream != self.get_stream() or !self.is_playing()):
			self.set_stream(audio_stream)
			self.play()
	
	if (data.sfx_set.empty() or data.sfx_set == "None" or data.sfx.empty() or data.sfx == "None"):
		self.stop()
