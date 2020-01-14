extends Node

func _ready():
	BackgroundManager.load_threaded()
	CharacterManager.load_threaded()
	SFXManager.load_threaded()
	BGMManager.load_threaded()
