extends Node

var conversation_list: Dictionary = {}

const POS_FAR_LEFT = "Far Left"
const POS_LEFT = "Left"
const POS_CENTER = "Center"
const POS_RIGHT = "Right"
const POS_FAR_RIGHT = "Far Right"

# ========== Server Processing Functions ==========

# Server function to process a request to create a new conversation
master func process_create_conversation(id: int, key: String, conversation_name: String):
	if (conversation_exists(conversation_name) or
			conversation_name == null or
			conversation_name.empty()):
		return
	
	process_conversation_request(id, key, "create_conversation", conversation_name)

# Server function to process a request to remove an existing conversation
master func process_remove_conversation(id: int, key: String, conversation_name: String):
	if not conversation_exists(conversation_name):
		return
	
	process_conversation_request(id, key, "remove_conversation", conversation_name)

# Server function to process a request for a player to enter an existing conversation
master func process_enter_conversation(id: int, key: String, conversation_name: String, position: String):
	if not conversation_exists(conversation_name):
		return
	
	process_player_conversation_request(id, key, "enter_conversation", conversation_name, position)

# Server function to process a request for a player to leave conversations
master func process_leave_conversation(id: int, key: String, conversation_name: String, position: String):
	#TODO: Validate
	process_player_conversation_request(id, key, "leave_conversation", conversation_name, position)

# ========== Server Processing Helper Functions ==========

# Helper function to process conversation requests that need the player's data
func process_player_conversation_request(id: int, key: String, request: String, conversation_name: String, position: String):
	if not NetworkManager.validate_key(id, key):
		return
	
	var player_data: PlayerData = NetworkManager.get_player_data(id)
	call_deferred(request, player_data, conversation_name, position)

# Helper function used to process a simple conversation request
func process_conversation_request(id: int, key: String, request: String, conversation_name: String):
	if not NetworkManager.validate_key(id, key):
		return
	
	call_deferred(request, conversation_name)
	send_update_conversation_list()

# ========== Conversation Management Functions ==========

# Gets a specific conversation from the list
func get_conversation(conversation_name: String):
	if conversation_list.has(conversation_name):
		return conversation_list.get(conversation_name)
	return null

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
		conversation_list[target].clear_players()
		conversation_list.erase(target)

# Adds a specified PlayerData into a position in a conversation already on the list
func enter_conversation(player: PlayerData, conversation: String, position: String) -> void:
	if conversation_list.has(conversation):
		var target = conversation_list.get(conversation)
		if not target.is_position_filled(position):
			leave_conversation(player, null, null)
			target.add_player(player, position)
			player.set_data("conversation", conversation)

# Removes player from a conversation entirely
func leave_conversation(player: PlayerData, _conversation, _position) -> void:
	var conversation = player.get_data("conversation")
	if conversation_list.has(conversation):
		var target = conversation_list.get(conversation)
		target.remove_player(player)

# Checks that a conversation exists in list. Returns false if it's null or
# is not on the conversation_list
func conversation_exists(conversation) -> bool:
	if conversation == null:
		return false
	
	return conversation_list.has(conversation)
