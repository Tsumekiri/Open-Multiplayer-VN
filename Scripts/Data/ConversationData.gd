extends Resource
class_name ConversationData

var data: Dictionary = {
	"name": "",
	"players": {
		ConversationManager.POS_FAR_LEFT: "",
		ConversationManager.POS_LEFT: "",
		ConversationManager.POS_CENTER: "",
		ConversationManager.POS_RIGHT: "",
		ConversationManager.POS_FAR_RIGHT: ""
	},
	"background": "",
	"bgm": "",
	"sfx": ""
}

func _init(name: String):
	data.name = name

# Simple getter for the conversation data
func get_data() -> Dictionary:
	return data

# Simple setter for the conversation data
func set_data(new_data: Dictionary) -> void:
	data = new_data

# Simple getter for the conversation name
func get_name() -> String:
	return data.name

# Returns whether a specific position already has a player
func is_position_filled(position: String) -> bool:
	if data.players.has(position):
		return data.players.get(position).is_empty()
	return false

# Check that a player is already in the conversation
func is_player_in(user: String) -> bool:
	for player in data.players.values():
		if user == player.get_server_data("user"):
			return true
	return false

# Adds a player to the conversation in the specified position
func add_player(player: PlayerData, position: String) -> void:
	if data.players.has(position):
		data.players[position] = player

# Removes a player from the conversation. Should be called by the server
func remove_player(player: PlayerData) -> void:
	var target = player.get_data("user")
	for person in data.players:
		if data.players[person].get_data("user") == target:
			var target_id = target.get_server_data("id")
			var target_key = target.get_server_data("key")
			
			PlayerManager.process_change_data(target_id, target_key, "conversation", "")
			data.players[person] = ""

# Removes all players from the conversation. Should be called by the server
func clear_players() -> void:
	for target in data.players:
		if data.players[target] != "":
			var player = data.players[target]
			var player_id = player.get_server_data("id")
			var player_key = player.get_server_data("key")
			
			PlayerManager.process_change_data(player_id, player_key, "conversation", "")
			data.players[target] = ""
