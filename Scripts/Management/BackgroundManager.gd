extends Node

var backgrounds: Dictionary = {}
const allowedExtensions: Array = ["png", "bmp", "jpg"]

# Loads all characters present in the server folder
func load_backgrounds(args) -> void:
	VNResourceLoader.load_vn_images(FileManager.get_folder_path(FileManager.BACKGROUNDS), self)
	
	print(backgrounds)
	for background in backgrounds.values():
		print(background.get_vn_images())

func load_resource(path: String):
	var background: String = path.get_basename()
	backgrounds[background] = MultiVN.Background.new(background, allowedExtensions)