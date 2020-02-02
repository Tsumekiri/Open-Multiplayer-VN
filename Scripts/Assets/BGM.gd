extends VNAudioSet
class_name BGM

# Extension of VNAudioSet meant for background music. They are separated
# from sound effects, for instance, as a means to facilitate writing
# specific behavior, or things like validation.

func _init(name: String, allowed_extensions: Array):
	setup(name, FileManager.get_resource_path(FileManager.BGM, name), allowed_extensions)
