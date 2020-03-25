extends Control

func _ready():
	for child in $DropdownList/Children.get_children():
		if child is OptionButton:
			child.connect("pressed", self, "mouse_entered_area")
			child.get_popup().connect("mouse_entered", self, "mouse_entered_area")

# Checks each of its children to see whether a dropdown is open
func has_dropdown_open() -> bool:
	for child in $DropdownList/Children.get_children():
		if child is OptionButton:
			if child.is_pressed():
				return true
	return false

# Runs on every input
func _input(event):
	if event is InputEventMouseMotion:
		if mouse_inside_area(event.position) and is_closed():
			mouse_entered_area()
		elif not mouse_inside_area(event.position) and is_open():
			mouse_exited_area()

# Checks the mouse is inside the area designated to open the TopBar
func mouse_inside_area(mouse_position: Vector2) -> bool:
	return mouse_position.y < 90

# Checks children are up, and closed on the top bar
func is_closed():
	return $DropdownList/Children.get_position().y == 0 and not $Tween.is_active()

# Checks children are down, and open on the top bar
func is_open():
	return $DropdownList/Children.get_position().y != 0 and not $Tween.is_active()

# Behaviour when mouse enters the area (for the TopBar)
func mouse_entered_area():
	$Tween.interpolate_property($DropdownList/Children,
		"rect_position",
		$DropdownList/Children.get_position(),
		Vector2(121.3, 75), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()

# Behaviour when the mouse exits the area (for the TopBar)
func mouse_exited_area():
	if not has_dropdown_open():
		$Tween.interpolate_property($DropdownList/Children,
			"rect_position",
			$DropdownList/Children.get_position(),
			Vector2(121.3, 0), 0.1, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
		$Tween.start()
