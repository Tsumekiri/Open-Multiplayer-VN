extends Panel

export(String) var title setget set_title, get_title

func set_title(pTitle: String):
	title = pTitle
	$Title.set_text(title)

func get_title():
	return title
