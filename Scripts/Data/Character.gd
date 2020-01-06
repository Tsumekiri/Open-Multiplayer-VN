extends Resource

# This is the resource used to store loaded character data.
# It loads and stores several Expressions, as well as its
# name, used for identification. Be careful with capitalization,
# as a different OS may treat it differently.

# Character data
var data: Dictionary = {
	"name": "",
	"expressions": {},
	"spriteFrames": SpriteFrames.new()
}

# Constructor
func _init(name: String):
	data.name = name
	
	var characterFolder: String = FileManager.get_resource_path(FileManager.CHARACTERS, data.name)
	if (characterFolder == null):
		print("ERROR: ROOT directory not set! Could not create character folder for " + data.name)
	else:
		FileManager.create_directory(characterFolder)
		load_expressions()
		load_sprite_frames()

# Returns the frames for an expression
func get_frames(expression: String):
	if (data.expressions.has(expression)):
		return data.expressions[expression].get_frames()
	return null

# Returns the number of expressions for the character
func get_expressions_size() -> int:
	return data.expressions.size()

# Returns the sprite frames for the character
func get_sprite_frames() -> SpriteFrames:
	return data.spriteFrames

# Loads the character's expressions
func load_expressions() -> void:
	var regex: RegEx = RegEx.new()
	regex.compile("^(.*)_(\\d+)\\.\\b(png)\\b$")
	
	var dir: Directory = Directory.new()
	dir.open(FileManager.get_resource_path(FileManager.CHARACTERS, data.name))
	dir.list_dir_begin()
	
	while true:
		var expression: String = dir.get_next()
		if (expression == ""):
			break
		
		var expressionMatch: RegExMatch = regex.search(expression.get_file())
		
		if (expressionMatch != null):
			add_dynamic_expression(expression, expressionMatch.get_string(1), expressionMatch.get_string(2))
		elif (expression.get_extension() == "png"):
			add_expression(expression, expression.get_basename())
	
	dir.list_dir_end()

# Loads the frames loaded by the Expressions into the character's sprite frames
func load_sprite_frames() -> void:
	for expression in data.expressions.values():
		for frame in expression.get_frames():
			load_sprite_each_frame(expression.get_name(), frame)

# Loads one frame for the expression
func load_sprite_each_frame(expression: String, texture: ImageTexture) -> void:
	if (not data.spriteFrames.has_animation(expression)):
		data.spriteFrames.add_animation(expression)
	data.spriteFrames.add_frame(expression, texture, data.spriteFrames.get_frame_count(expression))

# Adds the expression to the character's list of expressions
func add_expression(path: String, name: String) -> void:
	data.expressions[name] = MultiVN.Expression.new(data.name, name)

# Adds the animated expression to the character's list of expressions
func add_dynamic_expression(path: String, name: String, frame: String) -> void:
	if (frame == "1"):
		add_expression(path, name)
