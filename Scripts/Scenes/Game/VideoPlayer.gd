extends VideoPlayer

const MAX_HEIGHT: float = 600.0 # Change this if you change the target resolution on your project settings

var _last_bg_set
var _last_bg

func _ready():
	MessageManager.connect("message_received", self, "receive_message")

# Decides what to do after the sprite receives a message
func receive_message(data) -> void:
	if not data is Dictionary or not data.background is Dictionary:
		return

	if data.background.background_set == _last_bg_set and data.background.background == _last_bg:
		return
	
	hide()
	if data.background.is_video == "true":
		if is_no_background(data.background) and is_playing():
			stop()
		else:
			check_video(data.background)
	elif is_playing():
		stop()
	
	_last_bg_set = data.background.background_set
	_last_bg = data.background.background

# Checks if background should be removed
func is_no_background(data_background: Dictionary):
	return data_background.background or data_background.background == "None" or not data_background.background_set or data_background.background_set == "None"

# Checks whether background exists and sets it up
func check_video(data: Dictionary) -> void:
	var target = VideoManager.get_video_set(data.background_set)
	if target:
		setup_video(target, data.background)

# Sets background, fits it to screen and plays animation
func setup_video(background_set: VideoSet, video_name: String) -> void:
	var video = background_set.get_vn_video(video_name)
	if video and not (get_stream() and get_stream().get_file() == video.get_video().get_file() and is_playing()):
		set_stream(video.get_video())
		play()
		show()
