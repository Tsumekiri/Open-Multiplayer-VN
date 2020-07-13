extends AnimatedSprite
class_name VNAnimatedSprite

export(String) var sprite_position = ""

var _last_sprite_set
var _last_sprite

func _ready():
	MessageManager.connect("message_received", self, "receive_message")

# Decides what to do after the sprite receives a message
func receive_message(data) -> void:
	if not data is Dictionary:
		return
	
	hide()

	if sprite_position:
		var character = check_characters(data)

		if character and not (character.name == _last_sprite_set and character.expression == _last_sprite):
			setup_character(character.name, character.expression)
		elif character:
			if not self.playing:
				play(character.expression)
			show()

		if character:
			_last_sprite_set = character.name
			_last_sprite = character.expression
		else:
			_last_sprite_set = null
			_last_sprite = null
	elif "background_set" in data.background and "background" in data.background and data.background.is_video == "false":
		if not (data.background.background_set == _last_sprite_set and data.background.background == _last_sprite):
			check_background(data.background)
			
			_last_sprite_set = data.background.background_set
			_last_sprite = data.background.background
		else:
			if not self.playing:
				play(data.background.background)
			show()
		

# Checks if background should be removed
func is_no_background(data_background: Dictionary):
	return data_background.background or data_background.background == "None" or not data_background.background_set or data_background.background_set == "None"

# Checks whether background exists and sets it up
func check_background(data: Dictionary) -> bool:
	var target = BackgroundManager.get_background_set(data.background_set)
	if target:
		return setup_background(target, data.background)
	elif self.playing:
		stop()
	return false

# Sets background, fits it to screen and plays animation
func setup_background(background_set: BackgroundSet, background: String) -> bool:
	set_sprite_frames(background_set.get_sprite_frames())
	if frames.has_animation(background):
		Scaler.fit_sprite_fullscreen(self, background)
		play(background)
		show()
		return true
	return false

# Is a character sprite, checks received characters in message and sets it up if
# the position is right
func check_characters(data: Dictionary):
	for character in data.characters:
		if character.position == sprite_position and character.name:
			return character

# Sets character, fits to screen and plays animation
func setup_character(character: String, expression: String) -> void:
	var target = CharacterManager.get_character(character)
	if target:
		set_sprite_frames(target.get_sprite_frames())
		
		if frames.has_animation(expression):
			Scaler.fit_sprite_height(self, expression, sprite_position)
			play(expression)
			show()
