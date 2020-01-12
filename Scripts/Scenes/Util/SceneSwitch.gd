extends Button

signal switch_scene(target)
export(String, FILE, "*.tscn") var target

func _ready():
	connect("button_up", self, "emit_switch_scene")

func emit_switch_scene():
	emit_signal("switch_scene", target)
