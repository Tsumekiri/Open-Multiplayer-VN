extends AcceptDialog

func _ready():
	NetworkManager.connect("login_failed_s", self, "popup")
