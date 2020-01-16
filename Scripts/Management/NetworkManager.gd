extends Node

const CONFIG_PASSWORD_KEY = "password"
var commKey: Dictionary = {}
var commNode

signal login

func send_communication_key(id: int, key: String):
	rpc_id(id, "set_communication_key", id, key)

remotesync func set_communication_key(id: int, key: String):
	commKey[id] = key

# TODO: Missing usage of key, for communication with the correct user
# and avoid cheating

func set_communication_res(pNode):
	commNode = pNode

func get_communication_res():
	return commNode

func attempt_login(username: String, password: String, serverPass: String):
	var id = get_tree().get_network_unique_id()
	rpc("login_player", id, username, password, serverPass)

puppet func receive_login():
	emit_signal("login")

# Attempts to log player in. Registers player if it wasn't registered.
master func login_player(id: int, username: String, password: String, serverPass: String) -> bool:
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
master func register_player(id: int, username: String, password: String, serverPass: String) -> bool:
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