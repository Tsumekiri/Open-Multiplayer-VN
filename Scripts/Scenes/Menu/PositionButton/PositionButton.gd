extends Button

func _ready():
	connect("pressed", self, "button_pressed")

func button_pressed(status: bool):
	pass
	# Needs to check with conversation manager
	# if player is in a conversation. Afterwards,
	# only send change_data with position if
	# status (true) and send change data for
	# leaving the conversation if in a conversation
	# and status (false)
