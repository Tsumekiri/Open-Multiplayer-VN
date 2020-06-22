extends Resource
class_name PlayerData

signal data_changed(dictionary)
signal data_value_changed(key, value)
signal server_data_changed(dictionary)
signal server_data_value_changed(key, value)

var server_data: Dictionary = {
	"key": "",
	"address": ""
}

var data: Dictionary = {
	"user": "[SERVER]",
	"alias": "",
	"character": "",
	"expression": "",
	"background_set": "",
	"background": "",
	"is_video": "false",
	"bgm_set": "",
	"bgm": "",
	"sfx_set": "",
	"sfx": "",
	"position": "Center",
	"conversation": ""
}

func _init(player_id: int):
	server_data.id = player_id

func set_data(key: String, value: String):
	data[key] = value
	emit_signal("data_value_changed", key, value)

func get_data(key: String):
	return data[key]

func set_full_data(dict: Dictionary):
	data = dict
	emit_signal("data_changed", data)

func get_full_data():
	return data

func set_server_data(key: String, value: String):
	server_data[key] = value
	emit_signal("server_data_value_changed", key, value)

func get_server_data(key: String):
	return server_data[key]

func set_full_server_data(dict: Dictionary):
	server_data = dict
	emit_signal("server_data_changed", server_data)

func get_full_server_data():
	return server_data

# Returns all character data necessary to send a message
func get_character() -> Dictionary:
	return {
		"name": data.character,
		"expression": data.expression,
		"position": data.position
	}

# Returns all background data necessary to send a message
func get_background() -> Dictionary:
	return {
		"background_set": data.background_set,
		"background": data.background,
		"is_video": data.is_video
	}

# Returns all bgm data necessary to send a message
func get_bgm() -> Dictionary:
	return {
		"bgm_set": data.bgm_set,
		"bgm": data.bgm
	}

# Returns all sfx data necessary to send a message
func get_sfx() -> Dictionary:
	return {
		"sfx_set": data.sfx_set,
		"sfx": data.sfx
	}
