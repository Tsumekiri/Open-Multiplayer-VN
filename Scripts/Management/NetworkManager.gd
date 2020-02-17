extends Node

const CONFIG_PASSWORD_KEY: String = "password"
var communication_resource # Either a Client or a Server

var player_id
var players: Dictionary = {}

signal login_s

# Called by the server to assign a key to the player, both on itself
# and in the specific player's client, as well as initialize it into
# the dictionary
func send_player_init(id: int):
	var communication_key: String = CommunicationKey.create_unique_key()
	init_logged_player(id, communication_key)
	rpc_id(id, "init_logged_player", id, communication_key)

# Setter for the player's communication key, in serverData dictionary,
# as well as initializes player data
puppet func init_logged_player(id: int, key: String):
	players[id] = PlayerData.new(id)
	players[id].set_server_data("key", key)
	if (get_tree().get_network_unique_id() == id):
		receive_login()

# Initializes the server data
func init_server():
	var communication_key: String = CommunicationKey.create_unique_key()
	init_logged_player(1, communication_key)

# Setter for communication_resource. Should be careful not to ser a Client on a server, or the other way around
func set_communication_resource(new_resource):
	communication_resource = new_resource

# Getter for commResource. Is either a Client (on the client) or a Server resource (on the server)
func get_communication_resource():
	return communication_resource

# Called on the client to try and log into the server its peer is connected to
func attempt_login(username: String, password: int, server_password: int):
	var id: int = get_tree().get_network_unique_id()
	rpc("start_player_connection", id, username, password, server_password)

# When the server recognizes the client's login, it calls this function on the client,
# which then emits a signal so that it knows it was logged in
func receive_login():
	emit_signal("login_s")

# Starts player connection to server. Called by client
master func start_player_connection(id: int, username: String, password: int, server_password: int) -> void:
	if (login_player(username, password, server_password)):
		send_player_init(id)

# Attempts to log player in. Registers player if it wasn't registered.
func login_player(username: String, password: int, server_password: int) -> bool:
	if (register_player(username, password, server_password)):
		var path: String = FileManager.get_config_path(FileManager.PLAYER_LIST)
		var config: ConfigFile = ConfigFile.new()
		if (config.load(path) != OK):
			return false
		
		if (config.get_value(username, CONFIG_PASSWORD_KEY) == password):
			return true
	return false

# Attempts to register new player. Returns true if player was registered successfuly
# or was already registered.
func register_player(username: String, password: int, server_password: int) -> bool:
	if (not get_communication_resource().check_server_password(server_password)):
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

# Simple getter for players
func get_players() -> Dictionary:
	return players

# Gets a specific player's data
func get_player_data(id: int):
	if players.has(id):
		return players[id]
	return null

# Gets a specific player's data based on username
func get_player_by_user(user: String):
	for player in players.values():
		if player.get_data("user") == user:
			return player
	return null

# Getter for own player id
func get_id():
	return player_id

# Setter for own player id
func set_id(new_id):
	player_id = new_id

# Getter for the player's communication key
func get_key():
	return players[player_id].get_server_data("key")

# Checks that the key is valid
func validate_key(id: int, key: String):
	return players[id].get_server_data("key") == key
