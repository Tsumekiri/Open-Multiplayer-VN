extends Button

export(NodePath) var text_node_path
var text_node

# Called when the node enters the scene tree for the first time.
func _ready():
	text_node = get_node(text_node_path)
	connect("pressed", self, "send")

func send():
	var id = NetworkManager.get_id()
	var key = NetworkManager.get_key()
	
	if id != 1:
		MessageManager.rpc_id(1, "send_message", id, key, text_node.get_text())
	else:
		MessageManager.send_message(id, key, text_node.get_text())
	
	text_node.clear()
