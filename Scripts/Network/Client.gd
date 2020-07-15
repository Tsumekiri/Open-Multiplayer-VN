extends Resource

var tree: SceneTree

signal connection_failed
signal connection_succeeded
signal server_disconnected

func _init(pTree: SceneTree):
	self.tree = pTree

func connect_network(assets_folder: String, address: String, port: int):
	var peer = NetworkedMultiplayerENet.new()
	_connect_peer_signals(peer)
	
	if (peer.create_client(address, port) != OK):
		return false
	
	if (not FileManager.create_directories(assets_folder)):
		return false

	tree.set_network_peer(peer)
	NetworkManager.set_id(tree.get_network_unique_id())
	return true

func close_connection():
	NetworkManager.set_id(null)
	tree.get_network_peer().close_connection()
	tree.set_network_peer(null)

func _connect_peer_signals(peer: NetworkedMultiplayerENet):
	peer.connect("connection_failed", self, "_connection_failure")
	peer.connect("connection_succeeded", self, "_connection_success")
	peer.connect("server_disconnected", self, "_server_disconnected")

func _connection_success():
	emit_signal("connection_succeeded")

func _connection_failure():
	emit_signal("connection_failed")

func _server_disconnected():
	emit_signal("server_disconnected")
