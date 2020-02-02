extends Node

const ALIAS_DATA = "alias"
const CHARACTER_DATA = "character"
const EXPRESSION_DATA = "expression"
const BACKGROUND_SET_DATA = "background_set"
const BACKGROUND_DATA = "background"
const BGM_SET_DATA = "bgm_set"
const BGM_DATA = "bgm"
const SFX_SET_DATA = "sfx_set"
const SFX_DATA = "sfx"

func request_change_data(id: int, type: String, value):
	var key = NetworkManager.get_key()
	rpc_id(1, "process_change_data", key, id, type, value)

puppet func change_data(id: int, key: String, type: String, value):
	if not NetworkManager.validate_key(id, key):
		return
	
	NetworkManager.get_player_data(id).set_data(type, value)

master func process_change_data(key: String, id: int, type: String, value):
	if not NetworkManager.validate_key(id, key):
		return
	
	#TODO: Validate
	
	change_data(id, key, type, value)
	if (id != NetworkManager.get_id()):
		rpc_id(id, "change_data", id, key, type, value)
