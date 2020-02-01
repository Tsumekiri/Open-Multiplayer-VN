extends Control

signal open_menu(menu)

func _ready():
	$ButtonList/Children/Character.connect("button_up", self, "emit_open_menu", ["Character"])
	$ButtonList/Children/Background.connect("button_up", self, "emit_open_menu", ["Background"])
	$ButtonList/Children/Conversation.connect("button_up", self, "emit_open_menu", ["Conversation"])
	$ButtonList/Children/BGM.connect("button_up", self, "emit_open_menu", ["BGM"])
	$ButtonList/Children/SFX.connect("button_up", self, "emit_open_menu", ["SFX"])

func emit_open_menu(menu: String):
	emit_signal("open_menu", menu)

func mouse_entered_area():
	$Tween.interpolate_property($ButtonList/Children,
		"rect_position",
		$ButtonList/Children.get_position(),
		Vector2(-200, 0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func mouse_exited_area():
	$Tween.interpolate_property($ButtonList/Children,
		"rect_position",
		$ButtonList/Children.get_position(),
		Vector2(0, 0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
