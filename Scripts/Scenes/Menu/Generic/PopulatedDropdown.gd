extends OptionButton

signal item_selected_name(item_name)

func _ready():
	connect("item_selected", self, "emit_item_name_selected")

func populate(dictionary: Dictionary) -> void:
	clear()
	
	add_item("None")
	for item in dictionary:
		add_item(item)

func emit_item_name_selected(id: int):
	var item_name: String = get_item_text(get_item_index(id))
	emit_signal("item_selected_name", item_name)

func select_item_name(pName: String) -> void:
	for item in range(get_item_count()):
		if get_item_text(item) == pName:
			select(item)
			return
