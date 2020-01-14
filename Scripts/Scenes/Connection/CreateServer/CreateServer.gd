extends Panel

const fields = [
	"AssetPath",
	"MaxPlayers",
	"Port"
]

func _ready():
	$Create.connect("button_up", self, "create_server")
	$Cancel.connect("switch_scene", self, "switch_scene")

func switch_scene(scene: String) -> void:
	if (scene):
		get_tree().change_scene(scene)

func mandatory_fields_filled() -> bool:
	for field in fields:
		if (get_node(field).get_text() == null or get_node(field).get_text().strip_edges() == ""):
			return false
	return true

func create_server():
	if (not mandatory_fields_filled()):
		return
	
	var assetPath = $AssetPath.get_text().strip_edges()
	var password = $ServerPass.get_text()
	var maxPlayers = int($MaxPlayers.get_text().strip_edges())
	var port = int($Port.get_text().strip_edges())
	
	var server = MultiVN.Server.new()
	if (server.connect_network(assetPath, port, maxPlayers, password, get_tree())):
		NetworkManager.set_communication_node(server)
		switch_scene("res://Scenes/Util/Loading.tscn")
	else:
		server.queue_free()
