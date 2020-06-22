extends AnimatedSprite
class_name VNAnimatedSprite

export(String) var sprite_position = ""

const MAX_HEIGHT: float = 600.0 # Change this if you change the target resolution on your project settings

func _ready():
	MessageManager.connect("message_received", self, "receive_message")

# Decides what to do after the sprite receives a message
func receive_message(data) -> void:
	if not data is Dictionary:
		return
	
	hide()
	if sprite_position:
		check_characters(data)
	else:
		if data.background.is_video:
			hide()
		else:
			check_background(data.background)

# Checks whether background exists and sets it up
func check_background(data: Dictionary) -> void:
	var target = BackgroundManager.get_background_set(data.background_set)
	if target:
		setup_background(target, data.background)

# Sets background, fits it to screen and plays animation
func setup_background(background_set: BackgroundSet, background: String) -> void:
	set_sprite_frames(background_set.get_sprite_frames())
	if frames.has_animation(background):
		fit_sprite(background)
		play(background)
		show()

# Is a character sprite, checks received characters in message and sets it up if
# the position is right
func check_characters(data: Dictionary) -> void:
	for character in data.characters:
		if character.position == sprite_position and character.name:
			setup_character(character.name, character.expression)

# Sets character, fits to screen and plays animation
func setup_character(character: String, expression: String) -> void:
	var target = CharacterManager.get_character(character)
	if target:
		set_sprite_frames(target.get_sprite_frames())
		
		if frames.has_animation(expression):
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
	var original_height = get_tallest_texture(target_animation).get_height()
	if original_height and original_height > 0:
		var ratio: float = MAX_HEIGHT / original_height
		set_scale(Vector2(ratio, ratio))
