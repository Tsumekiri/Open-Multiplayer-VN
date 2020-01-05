extends Node

# Called when the node enters the scene tree for the first time.
func _ready():
	FileManager.createDirectories(FileManager.getGamePath())
	var expression = MultiVN.Expression.new("Kaleina", "idle")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
