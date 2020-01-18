extends Panel

const fields = [
	"AssetPath",
	"Address",
	"Port",
	"Username",
	"Password"
]

var assetPath: String
var address: String
var port: int
var serverPass: int
var username: String
var password: int

func _ready():
	$Login.connect("button_up", self, "login")
	$Cancel.connect("switch_scene", self, "switch_scene")
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
	
	assetPath = $AssetPath.get_text().strip_edges()
	address = $Address.get_text().strip_edges()
	port = int($Port.get_text().strip_edges())
	serverPass = $ServerPass.get_text().strip_edges().hash()
	username = $Username.get_text().strip_edges()
	password = $Password.get_text().strip_edges().hash()
	
	var client = MultiVN.Client.new(get_tree())
	client.connect("connection_succeeded", self, "client_connected")
	client.connect("connection_failed", self, "client_connection_failed")
	
	if (client.connect_network(assetPath, address, port)):
		NetworkManager.set_communication_res(client)

func client_connected() -> void:
	NetworkManager.attempt_login(username, password, serverPass)

func client_connection_failed() -> void:
	NetworkManager.set_communication_res(null)

func load_resources():
	switch_scene("res://Scenes/Util/Loading.tscn")