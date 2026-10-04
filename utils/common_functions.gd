extends Node


func set_anchors_to_current_ratio(control: Control) -> void:
	## this function is equivalent to setting a control nodes
	## anchors to current ration in the editor.
	
	var parent := control.get_parent() as Control
	if parent == null:
		return

	var parent_size := parent.size

	# Freeze the geometry we actually want.
	var original_position := control.position
	var original_size := control.size

	var left_ratio := original_position.x / parent_size.x
	var top_ratio := original_position.y / parent_size.y
	var right_ratio := (original_position.x + original_size.x) / parent_size.x
	var bottom_ratio := (original_position.y + original_size.y) / parent_size.y

	# Change all anchors.
	control.set_anchor(SIDE_LEFT, left_ratio, false)
	control.set_anchor(SIDE_TOP, top_ratio, false)
	control.set_anchor(SIDE_RIGHT, right_ratio, false)
	control.set_anchor(SIDE_BOTTOM, bottom_ratio, false)

	# Make the anchors themselves define the rectangle.
	control.offset_left = 0.0
	control.offset_top = 0.0
	control.offset_right = 0.0
	control.offset_bottom = 0.0


func scale_position(design_position: Vector2) -> Vector2:
	## Tweening position based on abosolute pixels breaks when
	## the window is resized. This helper function uses the
	## design size (godots default viewport size) to return
	## a scaled Vector2 based on the running windows current size.
	
	var DESIGN_SIZE := Vector2(1152.0, 648.0)
	var current_size := Vector2(get_viewport().get_visible_rect().size)

	return Vector2(
		design_position.x * (current_size.x / DESIGN_SIZE.x),
		design_position.y * (current_size.y / DESIGN_SIZE.y)
	)
