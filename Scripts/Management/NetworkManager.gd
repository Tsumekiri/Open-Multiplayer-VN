extends Node

const CONFIG_PASSWORD_KEY = "password"

# Attempts to log player in. Registers player if it wasn't registered.
master func login_player(id: String, username: String, password: String, serverPass: String) -> bool:
	if (register_player(id, username, password, serverPass)):
		var path: String = FileManager.get_config_path(FileManager.PLAYER_LIST)
		var config: ConfigFile = ConfigFile.new()
		if (config.load(path) != OK):
			return false
		
		if (config.get_value(username, CONFIG_PASSWORD_KEY) == password):
			return true
	return false

# Attempts to register new player. Returns true if player was registered successfuly
# or was already registered.
master func register_player(id: String, username: String, password: String, serverPass: String) -> bool:
	if (serverPass != password and password):
		return false
	
	var path: String = FileManager.get_config_path(FileManager.PLAYER_LIST)
	var config: ConfigFile = ConfigFile.new()
	if (config.load(path) == OK):
		if config.has_section(username):
			return true
	
	config.set_value(username, CONFIG_PASSWORD_KEY, password)
	
	if (config.save(path) != OK):
		return false
	return true