extends Control

func _on_Area2D_mouse_entered():
	$Tween.interpolate_property($DropdownList, "rect_position", $DropdownList.get_position(),
		Vector2(80, 20), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func _on_Area2D_mouse_exited():
	$Tween.interpolate_property($DropdownList, "rect_position", $DropdownList.get_position(),
		Vector2(80, -40), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
