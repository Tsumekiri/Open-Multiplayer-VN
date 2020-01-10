extends Node

# Generic VN resource loader. Iterates directory and calls
# the manager's load_resource function
func load_vn_resources(path: String, manager):
	var dir: Directory = Directory.new()
	
	if (dir.open(path) != OK):
		return
	
	dir.list_dir_begin()
	
	while true:
		var vnResourceFolder: String = dir.get_next()
		if (vnResourceFolder == ""):
			break
		elif (not vnResourceFolder.begins_with(".") and dir.current_is_dir()):
			manager.load_resource(vnResourceFolder)
	
	dir.list_dir_end()