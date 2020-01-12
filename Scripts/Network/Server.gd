extends Node

var password: String

func connect_network(assetsFolder: String, port: int, maxPlayers: int, password) -> bool:
	if (not FileManager.create_directories(assetsFolder)):
		return false
	
	var peer: NetworkedMultiplayerENet = NetworkedMultiplayerENet.new()
	if (peer.create_server(port, maxPlayers) != OK):
		return false
	
	if (password):
		self.password = password.hash()
	
	get_tree().set_network_peer(peer)
	return true

func close_connection():
	get_tree().get_network_peer().close_connection()
	get_tree().set_network_peer(null)