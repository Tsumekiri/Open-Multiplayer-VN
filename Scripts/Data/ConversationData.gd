extends Resource
class_name ConversationData

var data: Dictionary = {
	"name": "",
	"players": {
		ConversationManager.FAR_LEFT: "",
		ConversationManager.LEFT: "",
		ConversationManager.CENTER: "",
		ConversationManager.RIGHT: "",
		ConversationManager.FAR_RIGHT: ""
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

# Removes a player from the conversation
func remove_player(player: PlayerData) -> void:
	var target = player.get_data("user")
	for person in data.players:
		if data.players[person].get_data("user") == target:
			data.players[person] = ""
