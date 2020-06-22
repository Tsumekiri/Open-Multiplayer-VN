extends VNVideoSet
class_name VideoSet

func _init(name: String, allowed_extensions: Array):
    setup(name, FileManager.get_resource_path(FileManager.VIDEOS, name), allowed_extensions)