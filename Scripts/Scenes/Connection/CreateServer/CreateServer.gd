extends Panel

func _ready():
	$Cancel.connect("switch_scene", self, "switch_scene")

func switch_scene(scene: String):
	if (scene):
		get_tree().change_scene(scene)
