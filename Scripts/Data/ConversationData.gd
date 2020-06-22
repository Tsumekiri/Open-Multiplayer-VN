extends Resource
class_name ConversationData

var data: Dictionary = {
	"name": "",
	"players": {
		ConversationManager.POS_FAR_LEFT: null,
		ConversationManager.POS_LEFT: null,
		ConversationManager.POS_CENTER: null,
		ConversationManager.POS_RIGHT: null,
		ConversationManager.POS_FAR_RIGHT: null
	},
	"background_set": "",
	"background": "",
	"video_set": "",
	"video": "",
	"bgm_set": "",
	"bgm": ""
}

func _init(name: String):
	data.name = name

# Simple getter for the conversation data
func get_data() -> Dictionary:
	return data

# Simple setter for the conversation data
func set_data(new_data: Dictionary) -> void:
	data = new_data

# Simple setter for different conversation values, except for players
func set_value(key: String, value: String) -> void:
	if key in data:
		data[key] = value

# Simple getter for different conversation values
func get_value(key: String):
	if key in data:
		return data[key]

# Simple getter for the conversation name
func get_name() -> String:
	return data.name

# Getter for item in position
func get_position(position: String):
	return data.players[position]

# Returns whether a specific position already has a player
func is_position_filled(position: String) -> bool:
	if data.players.has(position):
		return data.players[position] != null
	return false

# Returns background set and name
func get_background() -> Dictionary:
	if data.video_set and data.video:
		return {
			"video_set": data.video_set,
			"video": data.video,
			"is_video": "true"
		}

	return {
		"background_set": data.background_set,
		"background": data.background,
		"is_video": "false"
	}

# Returns bgm set and name
func get_bgm() -> Dictionary:
	var bgm_data: Dictionary = {}
	bgm_data.bgm_set = data.bgm_set
	bgm_data.bgm = data.bgm
	
	return bgm_data

# Getter for players
func get_players():
	return data.players

# Check that a player is already in the conversation
func is_player_in(user: String) -> bool:
	for player in data.players.values():
		if user == player.get_server_data("user"):
			return true
	return false

# Returns position of user if he is in the conversation
func find_user_position(user: String):
	for position in data.players:
		if data.players[position]:
			if data.players[position] == user:
				return position
	return null

# Adds a player to the conversation in the specified position
func add_player(player: String, position: String) -> void:
	if data.players.has(position):
		data.players[position] = player

# Removes a player from the conversation. Should be called by the server
func remove_player(target: String) -> void:
	for person in data.players:
		if not data.players[person]:
			continue
		
		if data.players[person] == target:
			var player = NetworkManager.get_player_by_user(target)
			var target_id = player.get_server_data("id")
			var target_key = player.get_server_data("key")
			
			PlayerManager.process_change_data(target_key, target_id, "conversation", "")
			data.players[person] = null

# Removes all players from the conversation. Should be called by the server
func clear_players() -> void:
	for target in data.players:
		if data.players[target]:
			var player = NetworkManager.get_player_by_user(data.players[target])
			if player:
				var player_id = player.get_server_data("id")
				var player_key = player.get_server_data("key")
				
				PlayerManager.process_change_data(player_key, player_id, "conversation", "")
				data.players[target] = ""

# Gets formatted characters data for message sending
func get_characters() -> Array:
	var characters_data: Array = []

	for position in data.players:
		if data.players[position]:
			var player_data: PlayerData = NetworkManager.get_player_by_user(data.players[position])
			var message_data: Dictionary = player_data.get_character()
			message_data.position = position

			characters_data.append(message_data)

	return characters_data
