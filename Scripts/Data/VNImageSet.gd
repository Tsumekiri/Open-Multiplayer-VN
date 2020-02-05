extends Resource
class_name VNImageSet

# This is the resource used to store loaded image set resources.
# It loads and stores several VNImages, as well as its name,
# used for identification. Be careful with capitalization,
# as a different OS may treat it differently. The names are the
# names of their respective folders.

# Character data
var data: Dictionary = {
	"name": "",
	"vn_images": {},
	"sprite_frames": SpriteFrames.new()
}

# Constructor
# Note that allowed_extensions must contain an array of lowercase strings
func setup(name: String, folder_path: String, allowed_extensions: Array):
	data.name = name
	
	if (folder_path == null):
		print("ERROR: ROOT directory not set! Could not create character folder for " + data.name)
	else:
		load_vn_images(folder_path, allowed_extensions)
		load_sprite_frames()

# Returns the VNImages for this set
func get_vn_images():
	return data.vn_images

# Returns the frames of the VNImage
func get_frames(vn_image: String):
	if (data.vn_images.has(vn_image)):
		return data.vn_images[vn_image].get_frames()
	return null

# Returns the number of VNImages for the set
func get_vn_images_size() -> int:
	return data.vn_images.size()

# Returns the sprite frames for the VN image set
func get_sprite_frames() -> SpriteFrames:
	return data.sprite_frames

# Checks that required image exists
func has_vn_image(vn_image: String) -> bool:
	return data.vn_images.has(vn_image)

# Returns a specific image
func get_vn_image(vn_image: String):
	return data.vn_images[vn_image]

# Loads each VNImage found
func load_vn_images(folder_path: String, allowed_extensions: Array) -> void:
	var regex: RegEx = RegEx.new()
	regex.compile("^(.*)_(\\d+)\\.\\b" + get_extension_regex_group(allowed_extensions) + "\\b$")
	
	var dir: Directory = Directory.new()
	if (dir.open(folder_path) != OK):
		return
	
	dir.list_dir_begin()
	
	while true:
		var vn_image: String = dir.get_next()
		if (vn_image == ""):
			break
		
		var vn_image_match: RegExMatch = regex.search(vn_image.get_file())
		
		if (vn_image_match != null):
			add_dynamic_vn_image(vn_image_match.get_string(1), vn_image,
					folder_path, vn_image_match.get_string(2))
		
		elif (vn_image.get_extension().to_lower() in allowed_extensions):
			add_vn_image(vn_image.get_basename(), vn_image, folder_path)
	
	dir.list_dir_end()

# Forms the extensions group allowed by the RegEx
func get_extension_regex_group(allowed_extensions: Array):
	var result = "("
	for i in allowed_extensions:
		result += i + "|"
	return (result.rstrip("|") + ")")

# Puts the frames loaded by the VNImages into the character's sprite frames
func load_sprite_frames() -> void:
	for vn_image in data.vn_images.values():
		for frame in vn_image.get_frames():
			load_sprite_each_frame(vn_image.get_name(), frame)

# Puts one frame of the VNImage in the SpriteFrames
func load_sprite_each_frame(vn_image: String, texture: ImageTexture) -> void:
	if (not data.sprite_frames.has_animation(vn_image)):
		data.sprite_frames.add_animation(vn_image)
	data.sprite_frames.add_frame(vn_image, texture, data.sprite_frames.get_frame_count(vn_image))

# Adds the VNImage to the character's list of VNImages
func add_vn_image(name: String, file: String, folder_path: String) -> void:
	data.vn_images[name] = VNImage.new(data.name, file, folder_path)

# Adds the animated VNImage to the set's list of VNImages
func add_dynamic_vn_image(name: String, file: String, folder_path: String, frame: String) -> void:
	if (frame == "1"):
		add_vn_image(name, file, folder_path)
