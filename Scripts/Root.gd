extends Node

var thread: Thread = Thread.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	FileManager.create_directories(FileManager.get_game_path())
	thread.start(CharacterManager, "load_characters")

func _exit_tree():
	thread.wait_to_finish()
