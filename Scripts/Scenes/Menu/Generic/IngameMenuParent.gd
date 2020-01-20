extends Control

export(String) var selector

func _on_RightBar_open_menu(menu):
	if (menu == selector and not visible):
		change_visibility(true)
	else:
		change_visibility(false)

func change_visibility(pShow: bool):
	if (pShow):
		show()
	else:
		hide()
