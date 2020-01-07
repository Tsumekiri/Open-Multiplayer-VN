extends Node

var thread: Thread = Thread.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	FileManager.create_directories(FileManager.get_game_path())
	thread.start(CharacterManager, "load_characters")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
