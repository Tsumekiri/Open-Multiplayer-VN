extends Resource

var emitter
var target
var event: String
var function: String

func _init(emitter, target, event: String, function: String):
	self.emitter = emitter
	self.target = target
	self.event = event
	self.function = function

func connect_event() -> bool:
	if (emitter.connect(event, target, function) != OK):
		print("Failed to connect event " + event + " to function " + function)
		return false
	return true