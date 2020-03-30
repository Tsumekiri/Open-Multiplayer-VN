extends RichTextLabel

export(float) var normal_wait_time = 0.025
export(float) var slow_wait_time = 0.1

var all_visible = true
var text_timer : Timer

const SLOW_CHARACTERS : Array = [".", ",", "?"]

# Called when the node enters the scene tree for the first time.
func _ready():
	text_timer = Timer.new()
	text_timer.set_one_shot(true)
	add_child(text_timer)
	
	MessageManager.connect("message_received", self, "display_message")
	text_timer.connect("timeout", self, "next_visible_character")

# Used to check whether all characters in message are currently shown
func check_all_characters_shown() -> void:
	yield(get_tree(), "idle_frame") # Workaround get_total_character_count bug
	all_visible = (get_visible_characters() >= get_total_character_count())

# Starts next character timer according desired timing
func start_character_timer(slow: bool) -> void:
	if slow:
		text_timer.start(slow_wait_time)
	else:
		text_timer.start(normal_wait_time)

# Checks whether current character should use the slow_wait_time or the
# normal_wait_time
func is_current_character_slow() -> bool:
	var current_character = get_text()[get_visible_characters()]
	return current_character in SLOW_CHARACTERS

# Shows next character
func next_visible_character() -> void:
	var characters = get_visible_characters() + 1
	set_visible_characters(characters)
	yield(check_all_characters_shown(), "completed") # Workaround get_total_character_count bug
	
	if not all_visible:
		start_character_timer(is_current_character_slow())

# Displays a message as received
func display_message(data: Dictionary) -> void:
	if data.has("message"):
		set_visible_characters(0)
		set_bbcode(data["message"])
		
		yield(check_all_characters_shown(), "completed") # Workaround get_total_character_count bug
		if not all_visible:
			start_character_timer(is_current_character_slow())

# Shows all characters in message, bypassing timer
func show_all() -> void:
	if not text_timer.is_stopped():
		text_timer.stop()
	
	set_visible_characters(-1)
	all_visible = true
