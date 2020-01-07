extends Node

var ROOT: String

# Constants for path dictionary

const CHARACTERS: String = "CHARACTERS"
const BACKGROUNDS: String = "BACKGROUNDS"
const BGM: String = "BGM"
const SFX: String = "SFX"
const VIDEOS: String = "VIDEOS"

# Path dictionary
const PATH: Dictionary = {
	"CHARACTERS" : "Characters/",
	"BACKGROUNDS" : "Backgrounds/",
	"BGM" : "BGM/",
	"SFX" : "SFX/",
	"VIDEOS" : "Videos/"
}

# Function for creating directories
func create_directory(path: String) -> bool:
	var dir: Directory = Directory.new()
	print("Creating path: " + path)
	if (!dir.dir_exists(path)):
		if(dir.make_dir_recursive(path) != OK):
			return false
	return true

# Function for creating subdirectories of the base directory
func create_root_directory(subdirectory: String) -> bool:
	return create_directory(ROOT + subdirectory)

# Function to create the base directories for the server
func create_directories(baseFolder: String) -> bool:
	if (baseFolder == null || baseFolder.empty()):
		return false
	ROOT = baseFolder + "/"
	
	for folder in PATH.values():
		if (!(create_root_directory(folder))):
			return false
	return true

# Gets path for a folder that stores resources
func get_folder_path(key: String):
	if (!PATH.has(key) or ROOT == null):
		return null
	
	return ROOT + PATH[key] + "/"

# Gets the path for a particular resource
func get_resource_path(key: String, resource: String):
	if (!PATH.has(key) or ROOT == null):
		return null
	
	return ROOT + PATH[key] + resource + "/"

# Checks that the resource exists
func resource_exists(key: String, resource: String) -> bool:
	if (!PATH.has(key)):
		return false
	return file_exists(get_resource_path(key, resource))

# Checks that the file exists
func file_exists(path: String) -> bool:
	var file: File = File.new()
	return file.file_exists(path)

# Gets the base game path
func get_game_path() -> String:
	var dir: Directory = Directory.new()
	if (dir.open(".") != OK):
		return ""
	
	return dir.get_current_dir()