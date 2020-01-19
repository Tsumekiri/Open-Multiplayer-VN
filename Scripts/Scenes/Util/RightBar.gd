extends Control

signal open_menu(menu)

func _ready():
	$ButtonList/Character.connect("button_up", self, "emit_open_menu", ["Character"])
	$ButtonList/Background.connect("button_up", self, "emit_open_menu", ["Background"])
	$ButtonList/Conversation.connect("button_up", self, "emit_open_menu", ["Conversation"])
	$ButtonList/BGM.connect("button_up", self, "emit_open_menu", ["BGM"])
	$ButtonList/SFX.connect("button_up", self, "emit_open_menu", ["SFX"])

func emit_open_menu(menu: String):
	emit_signal("open_menu", menu)

func _on_Area2D_mouse_entered():
	$Tween.interpolate_property($ButtonList, "rect_position", $ButtonList.get_position(),
		Vector2(840, 0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Area2D_mouse_exited():
	$Tween.interpolate_property($ButtonList, "rect_position", $ButtonList.get_position(),
		Vector2(1050, 0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
