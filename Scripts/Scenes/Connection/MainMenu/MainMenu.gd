extends Panel

# Called when the node enters the scene tree for the first time.
func _ready():
	get_tree().set_current_scene(self)
	$Create.connect("switch_scene", self, "switch_scene")
	$Login.connect("switch_scene", self, "switch_scene")

func switch_scene(scene: String):
	if (scene):
		get_tree().change_scene(scene)