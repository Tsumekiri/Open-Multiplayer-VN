extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	FileManager.create_directories(FileManager.get_game_path())
	CharacterManager.load_threaded()
	BackgroundManager.load_threaded()
	SFXManager.load_threaded()
	BGMManager.load_threaded()
