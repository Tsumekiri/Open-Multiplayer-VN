extends TextureRect

func _ready():
    MessageManager.connect("unread_messages", self, "show")
    MessageManager.connect("message_received", self, "hide_on_message")

func hide_on_message(_data: Dictionary):
    hide()