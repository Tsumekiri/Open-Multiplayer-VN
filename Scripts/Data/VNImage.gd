extends Resource

# This is a VNImage resource, used in conjunction with VNImageSet
# to help the user select the apropriate set of images to use.
# Its main feature are the frames, loaded from images inside
# their folders.

# Expression data
var data: Dictionary = {
	"image_set": "",
	"name": "",
	"frames": [],
	"type": ""
}

# Constructor
func _init(image_set: String, file: String, folder_path: String):
	data.image_set = image_set
	data.name = file.get_basename()
	data.type = file.get_extension()
	
	load_vn_image(folder_path)

# Simple getter for data.name
func get_name() -> String:
	return data.name

# Simple getter for data.frames
func get_frames() -> Array:
	return data.frames

# VNImage loading function (dependent on frame loading function)
func load_vn_image(folder_path: String) -> void:
	var dir: Directory = Directory.new()
	if dir.file_exists(get_static_path(folder_path)):
		load_static_vn_image_files(folder_path)
	else:
		load_dynamic_vn_image_files(folder_path)

# Frame loading function
func load_frame(path: String) -> ImageTexture:
	var image: Image = Image.new()
	if image.load(path) != OK:
		return null
	
	var texture: ImageTexture = ImageTexture.new()
	texture.create_from_image(image, Texture.FLAG_FILTER)
	return texture

# Loader for static VNImage files
func load_static_vn_image_files(folder_path: String) -> void:
	data.frames.append(load_frame(get_static_path(folder_path)))

# Loader for animated VNImages
func load_dynamic_vn_image_files(folder_path: String) -> void:
	var next_frame: String = get_next_dynamic_path(folder_path)
	while FileManager.file_exists(next_frame):
		data.frames.append(load_frame(next_frame))
		next_frame = get_next_dynamic_path(folder_path)

# Helper functions that returns an expected static VNImage path
func get_static_path(folder_path: String) -> String:
	return folder_path + data.name + "." + data.type

# Helper function that returns the expected next path to frame of the
# animated VNImage
func get_next_dynamic_path(folder_path: String) -> String:
	return (folder_path + data.name + "_" +
			String(data.frames.size() + 1) + "." + data.type)

# Returns number of frames > 1
func is_dynamic() -> bool:
	return data.frames.size() > 1
