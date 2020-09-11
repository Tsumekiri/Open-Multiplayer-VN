extends Resource

var _client: WebSocketClient = WebSocketClient.new()
var _tree: SceneTree

signal connection_failed
signal connection_succeeded
signal server_disconnected

func _init(tree: SceneTree):
	_tree = tree
	connect_signals()

func connect_signals():
	_client.connect("connection_succeeded", self, "_connection_succeeded")
	_client.connect("connection_failed", self, "_connection_failed")
	_client.connect("server_disconnected", self, "_server_disconnected")

func _connection_succeeded():
	NetworkManager.set_id(_tree.get_network_unique_id())
	print("Connection succeeded")
	emit_signal("connection_succeeded")

func _connection_failed():
	print("Connection failed")
	emit_signal("connection_failed")

func _server_disconnected():
	print("Server disconnected")
	emit_signal("server_disconnected")

# Starts client, connecting it to host
func socket_connect(host: String, assets_folder: String):
	var err = _client.connect_to_url(host, PoolStringArray(), true)
	if err != OK:
		print("Websocket error on client connection (code: ", err, ")")
		return err

	if (not FileManager.create_directories(assets_folder)):
		return FAILED
	
	_tree.set_network_peer(_client)
	NetworkManager.set_should_poll(true)
	return err

# Stops client, disconnecting it from host
func socket_disconnect():
	if _tree.get_network_peer().is_connected_to_host():
		_tree.get_network_peer().disconnect_from_host()
	
	_tree.set_network_peer(null)
