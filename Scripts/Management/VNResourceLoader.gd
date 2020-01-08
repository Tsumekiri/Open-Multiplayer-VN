extends Node

func load_vn_images(path: String, manager):
	var dir: Directory = Directory.new()
	
	if (dir.open(path) != OK):
		return
	
	dir.list_dir_begin()
	
	while true:
		var vnImageFolder: String = dir.get_next()
		if (vnImageFolder == ""):
			break
		elif (not vnImageFolder.begins_with(".") and dir.current_is_dir()):
			manager.load_resource(vnImageFolder)
	
	dir.list_dir_end()