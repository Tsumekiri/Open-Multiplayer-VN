extends Node

var conversation_list: Dictionary = {}

const POS_FAR_LEFT = "Far Left"
const POS_LEFT = "Left"
const POS_CENTER = "Center"
const POS_RIGHT = "Right"
const POS_FAR_RIGHT = "Far Right"

# Asks server to create a new conversation
func request_create_conversation(conversation_name: String):
	var id = NetworkManager.get_id()
	var key = NetworkManager.get_key()
	
	if id != 1:
		rpc_id(1, "process_create_conversation", id, key, conversation_name)
	else:
		process_create_conversation(id, key, conversation_name)

# Server function to process a request to create a new conversation
master func process_create_conversation(id: int, key: String, conversation_name: String):
	if not NetworkManager.validate_key(id, key):
		return
	
	#TODO: Validate
	
	create_conversation(conversation_name)
	send_update_conversation_list()

# Gets a dictionary with each conversation data
func get_conversation_data_list() -> Dictionary:
	var result: Dictionary = {}
	for conversation in conversation_list.values():
		result[conversation.get_name()] = conversation.get_data()
	
	return result

# Server function to trigger an update to conversation_list in each logged user
master func send_update_conversation_list() -> void:
	var new_list: Dictionary = get_conversation_data_list()
	var player_list: Dictionary = NetworkManager.get_players()
	
	for player in player_list:
		var key = player_list.get(player).get_server_data("key")
		rpc_id(player, "update_conversation_list", player, key, new_list)

# Updates conversation_list with a dictionary of conversation data
puppet func update_conversation_list(id: int, key: String, list: Dictionary) -> void:
	if not NetworkManager.validate_key(id, key):
		return
	
	for conversation in list.values():
		conversation_list[conversation.name] = ConversationData.new(conversation.name)
		conversation_list[conversation.name].set_data(conversation)

# Creates a new conversation and adds it to the list
func create_conversation(conversation_name: String) -> void:
	var conversation: ConversationData = ConversationData.new(conversation_name)
	conversation_list[conversation.get_name] = conversation

# Removes a conversation from the list
func remove_conversation(target: String) -> void:
	if conversation_list.has(target):
		conversation_list.erase(target)
		#TODO: Have each player in conversation leave it

# Adds a specified PlayerData into a position in a conversation already on the list
func enter_conversation(player: PlayerData, conversation: String, position: String) -> void:
	if conversation_list.has(conversation):
		var target = conversation_list.get(conversation)
		if not target.is_position_filled(position):
			leave_conversation(player)
			target.add_player(player, position)
			player.set_data("conversation", conversation)

# Removes player from a conversation entirely
func leave_conversation(player: PlayerData) -> void:
	var conversation = player.get_data("conversation")
	if conversation_list.has(conversation):
		var target = conversation_list.get(conversation)
		target.remove_player(player)
		player.set_data("conversation", "")
