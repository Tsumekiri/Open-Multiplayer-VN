extends Resource

# This is a VNImage resource, used in conjunction with VNImageSet
# to help the user select the apropriate set of images to use.
# Its main feature are the frames, loaded from images inside
# their folders.

# Expression data
var data: Dictionary = {
	"imageSet": "",
	"name": "",
	"frames": [],
	"type": ""
}

# Constructor
func _init(imageSet: String, file: String, folderPath: String):
	data.imageSet = imageSet
	data.name = file.get_basename()
	data.type = file.get_extension()
	
	load_vn_image(folderPath)

# Simple getter for data.name
func get_name() -> String:
	return data.name

# Simple getter for data.frames
func get_frames() -> Array:
	return data.frames

# VNImage loading function (dependent on frame loading function)
func load_vn_image(folderPath: String) -> void:
	var dir: Directory = Directory.new()
	if dir.file_exists(get_static_path(folderPath)):
		load_static_vn_image_files(folderPath)
	else:
		load_dynamic_vn_image_files(folderPath)

# Frame loading function
func load_frame(path: String) -> ImageTexture:
	var image: Image = Image.new()
	if (image.load(path) != OK):
		return null
	
	var texture: ImageTexture = ImageTexture.new()
	texture.create_from_image(image, Texture.FLAG_FILTER)
	return texture

# Loader for static VNImage files
func load_static_vn_image_files(folderPath: String) -> void:
	data.frames.append(load_frame(get_static_path(folderPath)))

# Loader for animated VNImages
func load_dynamic_vn_image_files(folderPath: String) -> void:
	var nextFrame: String = get_next_dynamic_path(folderPath)
	while (FileManager.file_exists(nextFrame)):
		data.frames.append(load_frame(nextFrame))
		nextFrame = get_next_dynamic_path(folderPath)

# Helper functions that returns an expected static VNImage path
func get_static_path(folderPath: String) -> String:
	return folderPath + data.name + "." + data.type

# Helper function that returns the expected next path to frame of the
# animated VNImage
func get_next_dynamic_path(folderPath: String) -> String:
	return folderPath + data.name + "_" + String(data.frames.size() + 1) + "." + data.type

# Returns number of frames > 1
func is_dynamic() -> bool:
	return data.frames.size() > 1