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
func createDirectory(path: String) -> bool:
	var dir: Directory = Directory.new()
	print("Creating path: " + path)
	if (!dir.dir_exists(path)):
		if(dir.make_dir_recursive(path) != OK):
			return false
	return true

# Function for creating subdirectories of the base directory
func createRootDirectory(subdirectory: String) -> bool:
	return createDirectory(ROOT + subdirectory)

# Function to create the base directories for the server
func createDirectories(baseFolder: String) -> bool:
	if (baseFolder == null || baseFolder.empty()):
		return false
	ROOT = baseFolder + "/"
	
	var dir: Directory = Directory.new()
	for folder in PATH.values():
		if (!(createRootDirectory(folder))):
			return false
	return true

# Gets the path for a particular resource
func getPath(key: String, resource: String):
	if (!PATH.has(key) or ROOT == null):
		return null
	
	return ROOT + PATH[key] + resource + "/"

# Checks that the resource exists
func resourceExists(key: String, resource: String):
	if (!PATH.has(key)):
		return false
	return fileExists(getPath(key, resource))

# Checks that the file exists
func fileExists(path: String):
	var file: File = File.new()
	return file.file_exists(path)

# Gets the base game path
func getGamePath():
	var dir: Directory = Directory.new()
	dir.open(".")
	return dir.get_current_dir()