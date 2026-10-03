extends Control

var loaded_saves:Dictionary

func _ready() -> void:
	animate_buttons()
	initialize_file_info_panel()
	loaded_saves=DataIO.get_save_slots_view()
	$modal_panel.visible=false
	$modal_panel.modulate.a=0


func initialize_file_info_panel():
	$file_info_panel.modulate.a=0
	var anim:Tween=create_tween()
	anim.tween_property($file_info_panel,"modulate:a",1,.25)
	$file_info_panel/button_container.visible=false
	$file_info_panel/file_number_hint_Text.text=""


func load_file_info(file:String):
	DataIO.save_file_read(file)


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
		anim.tween_property(_button.get_child(0),"theme_override_colors/default_color:a",0,.35)
	
	var _move_anim_1:Tween=create_tween()
	_move_anim_1.set_trans(Tween.TRANS_SINE)
	_move_anim_1.tween_property(
		$buttons_container/file_buttons_container/file_1_button,
		'position',
		Vector2(125,150),
		.5)
	
	var _move_anim_2:Tween=create_tween()
	_move_anim_2.set_trans(Tween.TRANS_SINE)
	_move_anim_2.tween_property(
		$buttons_container/file_buttons_container/file_2_button,
		'position',
		Vector2(275,250),
		.5)
	
	var _move_anim_3:Tween=create_tween()
	_move_anim_3.set_trans(Tween.TRANS_SINE)
	_move_anim_3.tween_property(
		$buttons_container/file_buttons_container/file_3_button,
		'position',
		Vector2(425,350),
		.5)
	
	
	await get_tree().create_timer(.35).timeout

	$buttons_container/file_buttons_container/file_1_button/RichTextLabel.text="1"
	$buttons_container/file_buttons_container/file_2_button/RichTextLabel.text="2"
	$buttons_container/file_buttons_container/file_3_button/RichTextLabel.text="3"

	for _button:Button in $buttons_container/file_buttons_container.get_children():
		var anim_2:Tween=create_tween()
		anim_2.set_trans(Tween.TRANS_SINE)
		anim_2.tween_property(_button.get_child(0),"theme_override_colors/default_color:a",1,.2)


func _on_back_button_pressed() -> void:
	get_tree().root.get_node("MainMenu").animate_entry()
	$".".queue_free()


########## button hovered or focused behaviors ##########


func set_file_info(file_number:int):
	var prebuilt_str:String
	prebuilt_str="[u]          Save File "+str(file_number)+"          "
	$file_info_panel/file_number_hint_Text.text=prebuilt_str
	$file_info_panel/file_info_text.text=DataIO.decode_view(loaded_saves.get("file_"+str(file_number)))

func _on_file_1_button_focus_entered() -> void:
	set_file_info(1)


func _on_file_1_button_mouse_entered() -> void:
	set_file_info(1)


func _on_file_2_button_focus_entered() -> void:
	set_file_info(2)


func _on_file_2_button_mouse_entered() -> void:
	set_file_info(2)


func _on_file_3_button_focus_entered() -> void:
	set_file_info(3)


func _on_file_3_button_mouse_entered() -> void:
	set_file_info(3)


########## button actions ##########


func _on_file_1_button_pressed() -> void:
	animate_modal_in()


func _on_file_2_button_pressed() -> void:
	animate_modal_in()


func _on_file_3_button_pressed() -> void:
	animate_modal_in()


func animate_modal_in():
	$modal_panel.visible=true
	var anim:Tween=create_tween()
	anim.tween_property($modal_panel,"modulate:a",1,.15)


func _on_modal_panel_button_pressed() -> void:
	$modal_panel.visible=false
	$modal_panel.modulate.a=0
