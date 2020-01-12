extends Resource

var serverData: Dictionary = {
	"user": "",
	"key": "",
	"address": ""
}

var data: Dictionary = {
	"alias": "",
	"character": "",
	"expression": "",
	"bgm": "",
	"sfx": ""
}

func set_data(key: String, value: String):
	data[key] = value

func get_data(key: String):
	return data[key]

func set_full_data(dict: Dictionary):
	data = dict

func get_full_data():
	return data

func set_server_data(key: String, value: String):
	serverData[key] = value

func get_server_data(key: String):
	return serverData[key]

func set_full_server_data(dict: Dictionary):
	serverData = dict

func get_full_server_data():
	return serverData