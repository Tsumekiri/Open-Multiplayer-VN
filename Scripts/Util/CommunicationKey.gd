extends Resource
class_name CommunicationKey

# Following function creates a unit of random id, generated
# anew every time the game is opened.
static func create_key_unit():
	var id_unit = ""
	for x in range(5):
		id_unit += String(randi()%16)
	
	return id_unit

# This function creates a unique random id, for use each
# time the client wants to communicate with the server,
# ensuring the id sent is his.
static func create_unique_key():
	var unique_id = ""
	unique_id += create_key_unit()
	
	for x in range(4):
		unique_id += "-"
		unique_id += create_key_unit()
	
	return unique_id
