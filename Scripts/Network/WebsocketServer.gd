extends Resource

var _server: WebSocketServer = WebSocketServer.new()
var _password: int
var _tree: SceneTree

func _init(tree: SceneTree, password: String = ""):
	_tree = tree
	_password = password.hash()
	connect_signals()

func connect_signals():
	_server.connect("client_connected", self, "_client_connected")
	_server.connect("client_disconnected", self, "_client_disconnected")

func _client_connected(id: int, _protocol: String):
	print("Client connected!")

func _client_disconnected(id: int, _was_clean_close: bool):
	print("Client disconnected!")

# Checks the server password against argument. Returns true
# if there is no password as well
func check_server_password(password: int):
	if _password == password:
		return true
	return false

# Starts the server on specified port, with password
func socket_connect(assets_folder: String, port: int):
	if (not FileManager.create_directories(assets_folder)):
		return FAILED

	var err = _server.listen(port, PoolStringArray(), true)
	if err != OK:
		print("Websocket error on server listen (code: " + err + ")")
		return err

	_tree.set_network_peer(_server)
	NetworkManager.init_server()
	NetworkManager.set_id(_tree.get_network_unique_id())
	NetworkManager.set_should_poll(true)

	return err

# Stops server
func socket_disconnect():
	if _tree.get_network_peer().is_listening():
		_tree.get_network_peer().stop()
	
	_tree.set_network_peer(null)
