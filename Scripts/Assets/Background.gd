extends "res://Scripts/Data/VNImageSet.gd"

# Extension of VNImageSet meant for Backgrounds. They are separated
# from Characters, for instance, as a means to facilitate writing
# specific behavior, or things like validation.

func _init(name: String, allowed_extensions: Array):
	setup(name, FileManager.get_resource_path(FileManager.BACKGROUNDS, name), allowed_extensions)
