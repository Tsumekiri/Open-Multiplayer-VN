extends Node

const CONFIG_PASSWORD_KEY: String = "password"
var communication_resource # Either a Client or a Server

var player_id
var players: Dictionary = {}
var _should_poll: bool = false

signal login_s
signal login_failed_s

func _process(_delta):
	if _should_poll:
		get_tree().get_network_peer().poll()

func _exit_tree():
	var peer = get_tree().get_network_peer()
	if peer is WebSocketClient:
		disconnect_client(peer)
	elif peer is WebSocketServer:
		disconnect_server(peer)

# Used to disconnect client before closing the game window
func disconnect_client(peer: WebSocketClient):
	peer.disconnect_from_host()

# Used to stop server before closing the game window
func disconnect_server(peer: WebSocketServer):
	peer.stop()

# Used to erase a player from the list
func erase_player(id: int):
	ConversationManager.leave_conversation(players[id], null, null)
	players.erase(id)

# If set to true, network peer will start polling
func set_should_poll(should_poll: bool) -> void:
	_should_poll = should_poll

# Called by the server to assign a key to the player, both on itself
# and in the specific player's client, as well as initialize it into
# the dictionary
func send_player_init(id: int, username: String):
	var communication_key: String = CommunicationKey.create_unique_key()
	init_logged_player(id, communication_key, username)
	rpc_id(id, "init_logged_player", id, communication_key, username)

# Called by the server to send a connection failure to the player.
func send_connection_failed(id: int):
	rpc_id(id, "login_failed")

puppet func login_failed():
	emit_signal("login_failed_s")

# Setter for the player's communication key, in serverData dictionary,
# as well as initializes player data
puppet func init_logged_player(id: int, key: String, username: String):
	players[id] = PlayerData.new(id)
	players[id].set_server_data("key", key)
	players[id].set_data("user", username)
	if (get_tree().get_network_unique_id() == id):
		receive_login()

# Initializes the server data
func init_server():
	var communication_key: String = CommunicationKey.create_unique_key()
	init_logged_player(1, communication_key, "[Server]")

# Setter for communication_resource. Should be careful not to ser a Client on a server, or the other way around
func set_communication_resource(new_resource):
	communication_resource = new_resource

# Getter for commResource. Is either a Client (on the client) or a Server resource (on the server)
func get_communication_resource():
	return communication_resource

# Called on the client to try and log into the server its peer is connected to
func attempt_login(username: String, server_password: int):
	var id: int = get_tree().get_network_unique_id()
	rpc("start_player_connection", id, username, server_password)

# When the server recognizes the client's login, it calls this function on the client,
# which then emits a signal so that it knows it was logged in
func receive_login():
	emit_signal("login_s")

# Starts player connection to server. Called by client
master func start_player_connection(id: int, username: String, server_password: int) -> void:
	if (login_player(username, server_password)):
		send_player_init(id, username)

# Attempts to log player in. Registers player if it wasn't registered.
func login_player(username: String, server_password: int) -> bool:
	if (register_player(username, server_password)):
		return true
	return false

# Attempts to register new player. Returns true if player was registered successfuly
# or was already registered.
func register_player(username: String, server_password: int) -> bool:
	if (not get_communication_resource().check_server_password(server_password)):
		return false
	
	for player in players.values():
		if player.get_data("user") == username:
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
