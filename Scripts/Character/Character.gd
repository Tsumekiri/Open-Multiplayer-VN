extends "res://Scripts/Data/VNImageSet.gd"

# Extension of VNImageSet meant for Characters. They are separated
# from Backgrounds, for instance, as a means to facilitate writing
# specific behavior, or things like validation.

func _init(name: String):
	setup(name, FileManager.get_resource_path(FileManager.CHARACTERS, name))