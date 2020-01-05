extends Resource

# Character data
var data: Dictionary = {
	"name": "",
	"expressions": {}
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

# Adds the expression to the character's list of expressions
func add_expression(path: String, name: String) -> void:
	data.expressions[name] = MultiVN.Expression.new(data.name, name)

# Adds the animated expression to the character's list of expressions
func add_dynamic_expression(path: String, name: String, frame: String) -> void:
	if (frame == "1"):
		add_expression(path, name)

# Write character validation here, usually related to its
# files and server control
func validate_character():
	pass


