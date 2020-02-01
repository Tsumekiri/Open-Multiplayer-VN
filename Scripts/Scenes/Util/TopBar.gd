extends Control

func mouse_entered_area():
	$Tween.interpolate_property($DropdownList/Children,
		"rect_position",
		$DropdownList/Children.get_position(),
		Vector2(121.3, 75), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func mouse_exited_area():
	$Tween.interpolate_property($DropdownList/Children,
		"rect_position",
		$DropdownList/Children.get_position(),
		Vector2(121.3, 0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
