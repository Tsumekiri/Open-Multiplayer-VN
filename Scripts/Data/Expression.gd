extends Resource

# Expression data
var data: Dictionary = {
	"character": "",
	"name": "",
	"frames": []
}

# Constructor
func _init(character: String, name: String):
	data.character = character
	data.name = name
	
	load_expression()

# Simple getter for data.name
func get_name() -> String:
	return data.name

# Simple getter for data.frames
func get_frames() -> Array:
	return data.frames

# Expression loading function (dependent on frame loading function)
func load_expression() -> void:
	var dir: Directory = Directory.new()
	if dir.file_exists(get_static_path()):
		load_static_expression_files()
	else:
		load_dynamic_expression_files()

# Frame loading function
func load_frame(path: String) -> ImageTexture:
	var image: Image = Image.new()
	image.load(path)
	
	var texture: ImageTexture = ImageTexture.new()
	texture.create_from_image(image, Texture.FLAG_FILTER)
	return texture

# Loader for static expression files
func load_static_expression_files() -> void:
	data.frames.append(load_frame(get_static_path()))

# Loader for animated expressions
func load_dynamic_expression_files() -> void:
	var nextFrame: String = get_next_dynamic_path()
	while (FileManager.file_exists(nextFrame)):
		data.frames.append(load_frame(nextFrame))
		nextFrame = get_next_dynamic_path()

# Helper functions that returns an expected static expression path
func get_static_path() -> String:
	var characterFolder: String = FileManager.get_resource_path(FileManager.CHARACTERS, data.character)
	return characterFolder + data.name + ".png"

# Helper function that returns the expected next path to frame of the
# animated expression
func get_next_dynamic_path() -> String:
	var characterFolder: String = FileManager.get_resource_path(FileManager.CHARACTERS, data.character)
	return characterFolder + data.name + "_" + String(data.frames.size() + 1) + ".png"

# Returns number of frames > 1
func is_dynamic() -> bool:
	return data.frames.size() > 1