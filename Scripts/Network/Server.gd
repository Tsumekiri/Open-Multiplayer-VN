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
	var playerConnectedEvent = MultiVN.NetworkEvent.new(peer, self, "peer_connected", "create_key")
	playerConnectedEvent.connect_event()
	
	return true

func close_connection():
	get_tree().get_network_peer().close_connection()
	get_tree().set_network_peer(null)

func create_key(client_id: int):
	var keyRes = MultiVN.CommKey.new()
	NetworkManager.send_communication_key(client_id, keyRes.key)