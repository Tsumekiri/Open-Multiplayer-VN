extends Node

var conversation_list: Dictionary = {}

const POS_FAR_LEFT = "Far Left"
const POS_LEFT = "Left"
const POS_CENTER = "Center"
const POS_RIGHT = "Right"
const POS_FAR_RIGHT = "Far Right"

# Creates a new conversation and adds it to the list
func create_conversation(conversation_name: String) -> void:
	var conversation: ConversationData = ConversationData.new(conversation_name)
	conversation_list[conversation.get_name] = conversation

# Removes a conversation from the list
func remove_conversation(target: String) -> void:
	if conversation_list.has(target):
		conversation_list.erase(target)

# Adds a specified PlayerData into a position in a conversation already on the list
func enter_conversation(player: PlayerData, conversation: String, position: String) -> void:
	if conversation_list.has(conversation):
		var target = conversation_list.get(conversation)
		if not target.is_position_filled(position):
			leave_conversation(player)
			target.add_player(player, position)

# Removes player from a conversation entirely
func leave_conversation(player: PlayerData) -> void:
	var conversation = player.get_data("conversation")
	if conversation_list.has(conversation):
		var target = conversation_list.get(conversation)
		target.remove_player(player)
