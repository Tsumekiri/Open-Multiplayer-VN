extends Control

func _ready():
	for child in $DropdownList/Children.get_children():
		if child is OptionButton:
			child.connect("pressed", self, "mouse_entered_area")
			child.get_popup().connect("mouse_entered", self, "mouse_entered_area")

func has_dropdown_open() -> bool:
	for child in $DropdownList/Children.get_children():
		if child is OptionButton:
			if child.is_pressed():
				return true
	return false

func mouse_entered_area():
	$Tween.interpolate_property($DropdownList/Children,
		"rect_position",
		$DropdownList/Children.get_position(),
		Vector2(121.3, 75), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

func mouse_exited_area():
	if not has_dropdown_open():
		$Tween.interpolate_property($DropdownList/Children,
			"rect_position",
			$DropdownList/Children.get_position(),
			Vector2(121.3, 0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
