extends Node

const MAX_MESSAGE_STORAGE : int = 80

var current_message : int = -1
var message_list : Array = []
var read_messages : Array = []

signal message_received(data)
signal unread_messages()

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
	
	print(data)
	store_message(data)
	emit_signal("unread_messages")
	# This is what shows a message. Will later be used with _input(event)
	#emit_signal("message_received", data)

# Stores a message as it's received. If storage is maxed, shows first message and
# deletes it, before storing new one
func store_message(data: Dictionary) -> void:
	if message_list.size() < MAX_MESSAGE_STORAGE:
		message_list.append(data)
	else:
		var first_message = message_list.pop_front()
		message_list.append(data)
		if current_message == 0:
			emit_signal("message_received", first_message)
		else:
			current_message -= 1
	
	Logger.log_message(data)

# Stores a message that's been read. Used so that players can read messages
# they have already been through.
func store_read_message(data: Dictionary) -> void:
	if read_messages.size() < MAX_MESSAGE_STORAGE:
		read_messages.append(data)
	else:
		read_messages.pop_front()
		message_list.append(data)

# Checks whether current_message is the first message on list
func is_on_first_message() -> bool:
	return current_message == 0 or current_message == -1

# Checks whether current_message is the last received message
func is_on_last_message() -> bool:
	return current_message == (message_list.size() - 1)

# Shows next message and increments current_message
func show_next_message():
	if not is_on_last_message():
		current_message += 1
		emit_signal("message_received", message_list[current_message])
		store_read_message(message_list[current_message])
		if not is_on_last_message():
			emit_signal("unread_messages")

# Shows previous message and decrements current_message
func show_previous_message():
	if not is_on_first_message():
		current_message -= 1
		emit_signal("message_received", message_list[current_message])
		emit_signal("unread_messages")
