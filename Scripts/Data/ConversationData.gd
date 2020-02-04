extends Resource
class_name ConversationData

var data: Dictionary = {
	"players": {
		CharacterManager.POSITIONS.FAR_LEFT: "",
		CharacterManager.POSITIONS.LEFT: "",
		CharacterManager.POSITIONS.CENTER: "",
		CharacterManager.POSITIONS.RIGHT: "",
		CharacterManager.POSITIONS.FAR_RIGHT: ""
	},
	"background": "",
	"bgm": "",
	"sfx": ""
}

func is_player_in(user: String) -> bool:
	for player in data.players.values():
		if user == player.get_server_data("user"):
			return true
	return false
