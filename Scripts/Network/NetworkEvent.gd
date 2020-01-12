extends Resource

var emitter
var target
var event: String
var function: String

func _init(pEmitter, pTarget, pEvent: String, pFunction: String):
	self.emitter = pEmitter
	self.target = pTarget
	self.event = pEvent
	self.function = pFunction

func connect_event() -> bool:
	if (emitter.connect(event, target, function) != OK):
		print("Failed to connect event " + event + " to function " + function)
		return false
	return true