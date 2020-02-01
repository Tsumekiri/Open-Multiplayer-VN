extends "res://Scripts/Data/VNAudioSet.gd"

func _init(name: String, allowed_extensions: Array):
	setup(name, FileManager.get_resource_path(FileManager.SFX, name), allowed_extensions)
