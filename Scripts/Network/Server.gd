extends Resource

var password: int
var tree: SceneTree

func _init(pTree: SceneTree, pPass: String):
	self.tree = pTree
	self.password = pPass.hash()

# Checks the server password against argument. Returns true
# if there is no password as well
func check_server_password(pPassword: int):
	if (pPassword == password or not password):
		return true
	return false

# Called to start up the server
func connect_network(assets_folder: String, port: int, max_players: int) -> bool:
	if (not FileManager.create_directories(assets_folder)):
		return false
	
	var peer: NetworkedMultiplayerENet = NetworkedMultiplayerENet.new()
	if (peer.create_server(port, max_players) != OK):
		return false
	
	tree.set_network_peer(peer)
	return true

# Called to close the server's connection
func close_connection(tree):
	tree.get_network_peer().close_connection()
	tree.set_network_peer(null)
