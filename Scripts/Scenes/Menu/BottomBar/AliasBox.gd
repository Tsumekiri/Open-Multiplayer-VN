extends RichTextLabel

# Called when the node enters the scene tree for the first time.
func _ready():
	MessageManager.connect("message_received", self, "display_alias")

func display_alias(data: Dictionary) -> void:
	if data.has("alias"):
		set_bbcode(data["alias"])
