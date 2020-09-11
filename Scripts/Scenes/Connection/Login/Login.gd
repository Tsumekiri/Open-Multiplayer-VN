extends CenterContainer

var fields

export(NodePath) var asset_path_node
export(NodePath) var address_node
export(NodePath) var server_password_node
export(NodePath) var username_node
export(NodePath) var login_button_node
export(NodePath) var cancel_button_node

var asset_path: String
var address: String
var server_password: int
var username: String

func _ready():

	fields = [
		asset_path_node,
		address_node,
		username_node
	]

	get_node(login_button_node).connect("button_up", self, "login")
	get_node(cancel_button_node).connect("switch_scene", self, "switch_scene")
	NetworkManager.connect("login_s", self, "load_resources")

func switch_scene(scene) -> void:
	if (scene):
		get_tree().change_scene(scene)

func mandatory_fields_filled() -> bool:
	for field in fields:
		if (get_node(field).get_text() == null or get_node(field).get_text().strip_edges() == ""):
			return false
	return true

func login() -> void:
	if (not mandatory_fields_filled()):
		return
	
	asset_path = get_node(asset_path_node).get_text().strip_edges()
	address = get_node(address_node).get_text().strip_edges()
	server_password = get_node(server_password_node).get_text().strip_edges().hash()
	username = get_node(username_node).get_text().strip_edges()
	
	var client = MultiVN.WebsocketClient.new(get_tree())
	client.connect("connection_succeeded", self, "client_connected")
	client.connect("connection_failed", self, "client_connection_failed")
	
	if client.socket_connect(address, asset_path) == OK:
		NetworkManager.set_communication_resource(client)
	else:
		client_connection_failed()

func client_connected() -> void:
	NetworkManager.attempt_login(username, server_password)

func client_connection_failed() -> void:
	print("Failed to connect client")
	NetworkManager.set_communication_resource(null)
	NetworkManager.login_failed()

func load_resources():
	switch_scene("res://Scenes/Util/Loading.tscn")
