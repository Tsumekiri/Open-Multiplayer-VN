extends Node

# Change these if you change the target resolution on your project settings
var MAX_HEIGHT: float = float(ProjectSettings.get_setting("display/window/size/height"))
var MAX_WIDTH: float = float(ProjectSettings.get_setting("display/window/size/width"))
var HORIZONTAL_MARGIN: float = 100.0
var MAX_SPRITES: float = 6.0

# Gets the tallest frame in the animation, to fit the sprite to the screen's height
func get_tallest_texture(sprite: AnimatedSprite, target_animation: String) -> Texture:
	var tallest: Texture
	for idx in range(sprite.frames.get_frame_count(target_animation)):
		var target = sprite.frames.get_frame(target_animation, idx)
		if not tallest or target.get_height() > tallest.get_height():
			tallest = target
	return tallest

# Gets the widest frame in the animation, to fit the sprite to the screen's width
func get_widest_texture(sprite: AnimatedSprite, target_animation: String) -> Texture:
	var widest: Texture
	for idx in range(sprite.frames.get_frame_count(target_animation)):
		var target = sprite.frames.get_frame(target_animation, idx)
		if not widest or target.get_width() > widest.get_width():
			widest = target
	return widest

# Gets the target ratio to scale, from the widest or tallest frame, whichever is larger
func get_ratio_fullscreen(sprite: AnimatedSprite, target_animation: String) -> float:
	var original_height = get_tallest_texture(sprite, target_animation).get_height()
	var original_width = get_widest_texture(sprite, target_animation).get_width()

	if not original_height or not original_width:
		return 0.0;

	var target_width: float = MAX_WIDTH / float(original_width)
	var target_height: float = MAX_HEIGHT / float(original_height)

	if target_width >= target_height:
		return target_width
	else:
		return target_height

# Centers the sprite, for use after scaling
func center_sprite_fullscreen(sprite: AnimatedSprite) -> void:
	sprite.position.y = int(MAX_HEIGHT / 2.0);
	sprite.position.x = int(MAX_WIDTH / 2.0);

# Centers the character sprite, for use after scaling
func center_sprite_height(sprite: AnimatedSprite, position: String):
	var index = 1
	match position:
		"Left":
			index = 2
		
		"Center":
			index = 3
		
		"Right":
			index = 4
		
		"Far Right":
			index = 5
	
	var target_pos_x = (MAX_WIDTH - HORIZONTAL_MARGIN) / MAX_SPRITES
	target_pos_x *= index

	var target_pos_y = MAX_HEIGHT / 2.0

	sprite.position.x = target_pos_x + (HORIZONTAL_MARGIN / 2.0)
	sprite.position.y = target_pos_y

# Fits the sprite to the screen's height, resizes up if the sprite is too small, and
# resizes down if the sprite is too tall
func fit_sprite_height(sprite: AnimatedSprite, target_animation: String, position: String) -> void:
	var original_height = get_tallest_texture(sprite, target_animation).get_height()
	if original_height and original_height != 0:
		var ratio: float = MAX_HEIGHT / original_height
		sprite.set_scale(Vector2(ratio, ratio))
		center_sprite_height(sprite, position)

# Fits the sprite to the screen's width, resizes up if the sprite is too small, and
# resizes down if the sprite is too wide
func fit_sprite_fullscreen(sprite: AnimatedSprite, target_animation: String) -> void:
	var ratio = get_ratio_fullscreen(sprite, target_animation)
	if ratio != 0.0:
		sprite.set_scale(Vector2(ratio, ratio))
		center_sprite_fullscreen(sprite)
