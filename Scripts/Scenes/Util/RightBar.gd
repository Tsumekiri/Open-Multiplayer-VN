extends Control

func _on_Area2D_mouse_entered():
	$Tween.interpolate_property($ButtonList, "rect_position", $ButtonList.get_position(),
		Vector2(840, 0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()


func _on_Area2D_mouse_exited():
	$Tween.interpolate_property($ButtonList, "rect_position", $ButtonList.get_position(),
		Vector2(1050, 0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
