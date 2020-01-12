extends Node

func connect_network(assetsFolder: String, address: String, port: int, password):
	var peer = NetworkedMultiplayerENet.new()
	if (peer.create_client(address, port) != OK):
		return false
	
	get_tree().set_network_peer(peer)
	FileManager.create_directories(assetsFolder)
	
	# TODO: try password authentication
	
	return true