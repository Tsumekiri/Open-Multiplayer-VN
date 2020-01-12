extends Resource

var serverData: Dictionary = {
	"user": "",
	"key": ""
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

func set_full_data(dict: Dictionary):
	data = dict

func set_server_data(key: String, value: String):
	serverData[key] = value

func set_full_server_data(dict: Dictionary):
	serverData = dict