extends Button

func _ready():
	connect("button_down", $dialog, "popup_centered")
	$dialog.connect("dir_selected", self, "set_text")
