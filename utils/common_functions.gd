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
