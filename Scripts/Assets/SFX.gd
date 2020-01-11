extends "res://Scripts/Data/VNAudioSet.gd"

func _init(name: String, allowedExtensions: Array):
	setup(name, FileManager.get_resource_path(FileManager.SFX, name), allowedExtensions)