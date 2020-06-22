extends AudioStreamPlayer

export(String, "BGM", "SFX") var audio_type = "BGM"

func _ready():
	MessageManager.connect("message_received", self, "receive_message")

func receive_message(data) -> void:
	if not data is Dictionary:
		return
	
	if audio_type == "BGM" and data.bgm is Dictionary and load_bgm(data.bgm):
		self.play()
	
	elif audio_type == "SFX" and data.sfx is Dictionary and load_sfx(data.sfx):
		self.play()

func load_bgm(data: Dictionary) -> bool:
	if not "bgm_set" in data or not "bgm" in data:
		return false
	
	var bgm_set = BGMManager.get_bgm_set(data.bgm_set)
	if bgm_set and bgm_set is VNAudioSet:
		var audio_stream = bgm_set.get_vn_audio(data.bgm)
		if audio_stream:
			self.set_stream(audio_stream)
	return true

func load_sfx(data: Dictionary) -> bool:
	if not "sfx_set" in data or not "sfx" in data:
		return false
	
	var sfx_set = SFXManager.get_sfx_set(data.sfx_set)
	if sfx_set and sfx_set is VNAudioSet:
		var audio_stream = sfx_set.get_vn_audio(data.sfx)
		if audio_stream:
			self.set_stream(audio_stream)
	return true
