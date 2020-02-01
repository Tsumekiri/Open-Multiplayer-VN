extends Node

# Generic VN resource loader. Iterates directory and calls
# the manager's load_resource function
func load_vn_resources(path: String, manager):
	var dir: Directory = Directory.new()
	
	if (dir.open(path) != OK):
		return
	
	dir.list_dir_begin()
	
	while true:
		var vn_resource_folder: String = dir.get_next()
		if (vn_resource_folder == ""):
			break
		elif (not vn_resource_folder.begins_with(".") and dir.current_is_dir()):
			manager.load_resource(vn_resource_folder)
	
	dir.list_dir_end()
