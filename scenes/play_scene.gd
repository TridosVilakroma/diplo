extends Control


func _ready() -> void:
	animate_buttons()


func animate_buttons():
	animate_back_button()
	animate_file_buttons()


func animate_back_button():
	var _button:Button=$buttons_container/back_button
	_button.scale.y=0
	_button.pivot_offset=_button.size/2
	var anim:Tween=create_tween()
	anim.tween_property(_button,"scale:y",1,.1)
	anim.tween_property(_button,"scale:y",-1,.2)
	anim.tween_property(_button,"scale:y",1,.2)


func animate_file_buttons():
	for _button:Button in $buttons_container/file_buttons_container.get_children():
		var anim:Tween=create_tween()
		anim.set_trans(Tween.TRANS_SINE)
		anim.tween_property(_button.get_child(0),"theme_override_colors/default_color:a",0,.75)
	
	var _move_anim_1:Tween=create_tween()
	_move_anim_1.set_trans(Tween.TRANS_SINE)
	_move_anim_1.tween_property(
		$buttons_container/file_buttons_container/file_1_button,
		'position',
		Vector2(225,150),
		.5)
	
	var _move_anim_2:Tween=create_tween()
	_move_anim_2.set_trans(Tween.TRANS_SINE)
	_move_anim_2.tween_property(
		$buttons_container/file_buttons_container/file_2_button,
		'position',
		Vector2(425,250),
		.5)
	
	var _move_anim_3:Tween=create_tween()
	_move_anim_3.set_trans(Tween.TRANS_SINE)
	_move_anim_3.tween_property(
		$buttons_container/file_buttons_container/file_3_button,
		'position',
		Vector2(625,350),
		.5)
	
	
	await get_tree().create_timer(.75).timeout

	$buttons_container/file_buttons_container/file_1_button/RichTextLabel.text="File 1"
	$buttons_container/file_buttons_container/file_2_button/RichTextLabel.text="File 2"
	$buttons_container/file_buttons_container/file_3_button/RichTextLabel.text="File 3"

	for _button:Button in $buttons_container/file_buttons_container.get_children():
		var anim_2:Tween=create_tween()
		anim_2.set_trans(Tween.TRANS_SINE)
		anim_2.tween_property(_button.get_child(0),"theme_override_colors/default_color:a",1,.2)
		


func _on_back_button_pressed() -> void:
	get_tree().root.get_child(1).animate_entry()
	$".".queue_free()
