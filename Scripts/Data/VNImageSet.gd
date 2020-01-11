extends Resource

# This is the resource used to store loaded image set resources.
# It loads and stores several VNImages, as well as its name,
# used for identification. Be careful with capitalization,
# as a different OS may treat it differently. The names are the
# names of their respective folders.

# Character data
var data: Dictionary = {
	"name": "",
	"vnImages": {},
	"spriteFrames": SpriteFrames.new()
}

# Constructor
# Note that allowedExtensions must contain an array of lowercase strings
func setup(name: String, folderPath: String, allowedExtensions: Array):
	data.name = name
	
	if (folderPath == null):
		print("ERROR: ROOT directory not set! Could not create character folder for " + data.name)
	else:
		load_vn_images(folderPath, allowedExtensions)
		load_sprite_frames()

# Returns the VNImages for this set
func get_vn_images():
	return data.vnImages

# Returns the frames of the VNImage
func get_frames(vnImage: String):
	if (data.vnImages.has(vnImage)):
		return data.vnImages[vnImage].get_frames()
	return null

# Returns the number of VNImages for the set
func get_vn_images_size() -> int:
	return data.vnImages.size()

# Returns the sprite frames for the VN image set
func get_sprite_frames() -> SpriteFrames:
	return data.spriteFrames

# Loads each VNImage found
func load_vn_images(folderPath: String, allowedExtensions: Array) -> void:
	var regex: RegEx = RegEx.new()
	regex.compile("^(.*)_(\\d+)\\.\\b" + get_extension_regex_group(allowedExtensions) + "\\b$")
	
	var dir: Directory = Directory.new()
	if (dir.open(folderPath) != OK):
		return
	
	dir.list_dir_begin()
	
	while true:
		var vnImage: String = dir.get_next()
		if (vnImage == ""):
			break
		
		var vnImageMatch: RegExMatch = regex.search(vnImage.get_file())
		
		if (vnImageMatch != null):
			add_dynamic_vn_image(vnImageMatch.get_string(1), vnImage, folderPath, vnImageMatch.get_string(2))
		elif (vnImage.get_extension().to_lower() in allowedExtensions):
			add_vn_image(vnImage.get_basename(), vnImage, folderPath)
	
	dir.list_dir_end()

# Forms the extensions group allowed by the RegEx
func get_extension_regex_group(allowedExtensions: Array):
	var result = "("
	for i in allowedExtensions:
		result += i + "|"
	return (result.rstrip("|") + ")")

# Puts the frames loaded by the VNImages into the character's sprite frames
func load_sprite_frames() -> void:
	for vnImage in data.vnImages.values():
		for frame in vnImage.get_frames():
			load_sprite_each_frame(vnImage.get_name(), frame)

# Puts one frame of the VNImage in the SpriteFrames
func load_sprite_each_frame(vnImage: String, texture: ImageTexture) -> void:
	if (not data.spriteFrames.has_animation(vnImage)):
		data.spriteFrames.add_animation(vnImage)
	data.spriteFrames.add_frame(vnImage, texture, data.spriteFrames.get_frame_count(vnImage))

# Adds the VNImage to the character's list of VNImages
func add_vn_image(name: String, file: String, folderPath: String) -> void:
	data.vnImages[name] = MultiVN.VNImage.new(data.name, file, folderPath)

# Adds the animated VNImage to the set's list of VNImages
func add_dynamic_vn_image(name: String, file: String, folderPath: String, frame: String) -> void:
	if (frame == "1"):
		add_vn_image(name, file, folderPath)
