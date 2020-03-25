extends AnimatedSprite
class_name VNAnimatedSprite

export(String) var sprite_position = ""

const MAX_HEIGHT: float = 600.0 # Change this if you change the target resolution on your project settings
const EMPTY_ANIMATION: String = "None"

func _ready():
	MessageManager.connect("message_received", self, "receive_message")

# Decides what to do after the sprite receives a message
func receive_message(data) -> void:
	if not data is Dictionary:
		return
	
	hide()
	for character in data.characters:
		if character.position == sprite_position and character.name:
			setup_character(character.name, character.expression)

# Sets character, fits to screen and plays animation
func setup_character(character: String, expression: String):
	var target = CharacterManager.get_character(character)
	set_sprite_frames(target.get_sprite_frames())
	fit_sprite(expression)
	play(expression)
	
	show()

# Gets the tallest frame in the animation, to fit the sprite to the screen
func get_tallest_texture(target_animation: String) -> Texture:
	var tallest: Texture
	for idx in range(frames.get_frame_count(target_animation)):
		var target = frames.get_frame(target_animation, idx)
		if not tallest or target.get_height() > tallest.get_height():
			tallest = target
	return tallest

# Fits the sprite to the screen, resizes up if the sprite is too small, and
# resizes down if the sprite is to tall
func fit_sprite(target_animation: String) -> void:
	if not target_animation or target_animation == EMPTY_ANIMATION:
		return
	
	var original_height = get_tallest_texture(target_animation).get_height()
	if original_height and original_height > 0:
		var ratio: float = MAX_HEIGHT / original_height
		set_scale(Vector2(ratio, ratio))
