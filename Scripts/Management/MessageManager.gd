extends Node

const MAX_MESSAGE_STORAGE : int = 80

var message_count = 0

var current_message : int = -1
var message_list : Array = []
var read_messages : Array = []

var current_message_shown : bool = true

signal message_received(data)
signal unread_messages()
signal finish_current_message()

# Gets data and propagates message
master func send_message(id: int, key: String, message: String):
	if not NetworkManager.validate_key(id, key):
		return
	
	var player_data: PlayerData =  NetworkManager.get_player_data(id);
	var data: Dictionary = {
		"alias": player_data.get_data("alias"),
		"message": message,
		"characters": [],
		"background": {},
		"sfx": {},
		"bgm": {}
	}
	
	var conversation_name = player_data.get_data("conversation")
	if not conversation_name.empty():
		var conversation = ConversationManager.get_conversation(conversation_name)
		
		# Player in conversation, set data accordingly
		if conversation:
			data.characters = conversation.get_characters()
			data.background = conversation.get_background()
			data.bgm = conversation.get_bgm()
	else:
		data.characters = [player_data.get_character()]
		data.background = player_data.get_background()
		data.bgm = player_data.get_bgm()
	
	data.sfx = player_data.get_sfx()
	
	for player in NetworkManager.get_players():
		if player != 1:
			var send_key: String = NetworkManager.get_player_data(player).get_server_data("key")
			rpc_id(player, "receive_message", send_key, data)
		else:
			receive_message(NetworkManager.get_key(), data)

# Expected dictionary:
# {
# alias: "",
# message "", 
# characters: [ { name: "", expression : "", position: "" } ],
# background: { background_set: "", background: "" },
# sfx_list: { sfx_set: "", sfx: "" },
# bgm: { bgm_set: "", bgm: "" }
# }
puppet func receive_message(key: String, data: Dictionary):
	var id = NetworkManager.get_id()
	if not NetworkManager.validate_key(id, key):
		return
	
	store_message(data)
	print(data)
	emit_signal("unread_messages")
	# This is what shows a message. Will later be used with _input(event)
	#emit_signal("message_received", data)

# Stores a message as it's received. If storage is maxed, shows first message and
# deletes it, before storing new one
func store_message(data: Dictionary) -> void:
	data["message_id"] = message_count
	message_count += 1

	if message_list.size() == MAX_MESSAGE_STORAGE:
		message_list.pop_front()
	
	message_list.append(data)
	Logger.log_message(data)

# Checks whether current_message is the first message on list
func is_on_first_message() -> bool:
	if message_list.empty():
		return true
	else:
		var first_message = message_list.front()
		return first_message["message_id"] == current_message

# Checks whether current_message is the last received message
func is_on_last_message() -> bool:
	if message_list.empty():
		return true
	else:
		var last_message = message_list.back()
		return last_message["message_id"] == current_message

# Returns the current message based on a binary search
func get_current_message():
	for message in message_list:
		if message["message_id"] == current_message:
			return message
	return null

func send_finish_current_message():
	emit_signal("finish_current_message")
	finished_current_message()

func finished_current_message():
	current_message_shown = true

# Shows next message and increments current_message
func show_next_message():
	if not current_message_shown:
		send_finish_current_message()
	elif not is_on_last_message():
		current_message += 1
		var target_message = get_current_message()
		if not target_message and not message_list.empty():
			target_message = message_list.front()
			current_message = target_message["message_id"]
		
		show_message(target_message)

# Shows previous message and decrements current_message
func show_previous_message():
	if not is_on_first_message():
		current_message -= 1
		var target_message = get_current_message()
		if not target_message and not message_list.empty():
			target_message = message_list.back()
			current_message = target_message["message_id"]

		show_message(target_message)

# Function that properly emits the signal that displays a message
func show_message(target_message: Dictionary):
	current_message_shown = false
	emit_signal("message_received", target_message)
	if not is_on_last_message():
		emit_signal("unread_messages")