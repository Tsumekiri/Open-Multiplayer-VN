extends Resource

var server_data: Dictionary = {
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
	server_data[key] = value

func get_server_data(key: String):
	return server_data[key]

func set_full_server_data(dict: Dictionary):
	server_data = dict

func get_full_server_data():
	return server_data
