extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	FileManager.create_directories(FileManager.get_game_path())
	CharacterManager.load_characters()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
