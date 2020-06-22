extends VideoPlayer

const MAX_HEIGHT: float = 600.0 # Change this if you change the target resolution on your project settings

func _ready():
	MessageManager.connect("message_received", self, "receive_message")

# Decides what to do after the sprite receives a message
func receive_message(data) -> void:
	if not data is Dictionary:
		return
	
	hide()
	if data.background.is_video == "true":
		check_video(data.background)
		show()

# Checks whether background exists and sets it up
func check_video(data: Dictionary) -> void:
	var target = VideoManager.get_video_set(data.background_set)
	if target:
		setup_video(target, data.background)

# Sets background, fits it to screen and plays animation
func setup_video(background_set: VideoSet, video_name: String) -> void:
	var video = background_set.get_vn_video(video_name)
	if video and not (self.get_stream() and self.get_stream().get_file() == video.get_video().get_file() and self.is_playing()):
		self.set_stream(video.get_video())
		self.play()
