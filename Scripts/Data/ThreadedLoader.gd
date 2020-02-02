extends Node
class_name ThreadedResourceLoader

var thread: Thread = Thread.new()
var cancel_loading: bool = false

signal loading_complete_s

# Starts loading on a separate thread
func load_threaded() -> void:
	thread.start(self, "_load_resources")

# Sets thread to inactive after loading
func _finish_loading() -> void:
	thread.call_deferred("wait_to_finish")
	emit_signal("loading_complete_s")

# Called on exit
func _exit_tree():
	if thread.is_active():
		cancel_loading = true
		thread.wait_to_finish()
		print(name + " has stopped loading...")
