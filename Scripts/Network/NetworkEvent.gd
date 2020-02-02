extends Resource
class_name NetworkEvent

# This only really exists to centralize some event-related
# error handling. Other than printing an error message
# for debugging without cluttering the code, it's pretty
# useless.

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
