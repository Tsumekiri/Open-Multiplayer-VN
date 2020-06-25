extends OptionButton
class_name PopulatedDropdown

export(String) var data_key

signal item_selected_name(item_name)
signal data_selected(id, key, value)

func _ready():
	connect("item_selected", self, "emit_item_name_selected")
	connect("data_selected", PlayerManager, "request_change_data")
	PlayerManager.connect("data_changed", self, "select_server_data")

# Populates items based on a dictionary
func populate(dictionary: Dictionary, metadata=null) -> void:
	clear()
	add_dictionary(dictionary, metadata, true)

# Adds items based on a dictionary
func add_dictionary(dictionary: Dictionary, metadata=null, add_none=true) -> void:
	if add_none:
		add_item("None")
	
	for item in dictionary:
		add_item(item)
		if metadata:
			set_item_metadata(get_item_count() - 1, metadata)

# Emits custom signal for item_selected that includes its text
func emit_item_name_selected(id: int):
	var item_name: String = get_item_text(get_item_index(id))
	emit_signal("item_selected_name", item_name)
	emit_signal("data_selected", NetworkManager.get_id(), data_key, item_name)

# Selects an item by text, if item exists
func select_item_name(pName: String) -> void:
	for item in range(get_item_count()):
		if get_item_text(item) == pName:
			select(item)
			return

# Updates selected item based on key-value pair received from server data signal
func select_server_data(key: String, value: String) -> void:
	if key == data_key:
		select_item_name(value)
