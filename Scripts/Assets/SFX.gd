extends VNAudioSet
class_name SFX

# Extension of VNAudioSet meant for sound effects. They are separated
# from background music, for instance, as a means to facilitate writing
# specific behavior, or things like validation.

func _init(name: String, allowed_extensions: Array):
	setup(name, FileManager.get_resource_path(FileManager.SFX, name), allowed_extensions)
