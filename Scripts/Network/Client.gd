extends Node

func connect_network(assetsFolder: String, address: String, port: int, password):
	if (not FileManager.create_directories(assetsFolder)):
		return false
	
	var peer = NetworkedMultiplayerENet.new()
	if (peer.create_client(address, port) != OK):
		return false
	
	get_tree().set_network_peer(peer)
	
	return true

func close_connection():
	get_tree().get_network_peer().close_connection()
	get_tree().set_network_peer(null)