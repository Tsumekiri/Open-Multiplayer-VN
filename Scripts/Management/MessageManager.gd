extends Node

var message_list : Array = []

signal message_received(data)

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
		data.characters = player_data.get_character()
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
	emit_signal("message_received", data)
