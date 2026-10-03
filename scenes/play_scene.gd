extends Control

var loaded_saves:Dictionary
var current_file:String
var copy_flag:bool=false
var delete_flag:bool=false


func _ready() -> void:
	animate_buttons()
	initialize_file_info_panel()
	loaded_saves=DataIO.get_save_slots_view()
	$file_control_modal_panel.visible=false
	$file_control_modal_panel.modulate.a=0
	$file_select_modal.visible=false


func initialize_file_info_panel():
	$file_info_panel.modulate.a=0
	var anim:Tween=create_tween()
	anim.tween_property($file_info_panel,"modulate:a",1,.25)
	$file_info_panel/file_number_hint_Text.text=""
	$file_info_panel/file_control_buttons.visible=false
	$file_select_modal/confirm_panel.visible=false


func reset_file_info_panel():
	$file_info_panel/file_number_hint_Text.text=""
	$file_info_panel/file_info_text.text="[b]Select a Save file\nto play"
	$file_info_panel/file_control_buttons.visible=false
	$file_select_modal/confirm_panel.visible=false


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


#################### button actions ####################


func set_file_info(file_number:int):
	var prebuilt_str:String
	prebuilt_str="[u]          Save File "+str(file_number)+"          "
	$file_info_panel/file_number_hint_Text.text=prebuilt_str
	$file_info_panel/file_info_text.text=DataIO.decode_view(loaded_saves.get("file_"+str(file_number)))


func _on_file_1_button_pressed() -> void:
	current_file="file_1"
	set_file_info(1)
	animate_modal_in()
	add_file_control_buttons_with_context(1)


func _on_file_2_button_pressed() -> void:
	current_file="file_2"
	set_file_info(2)
	animate_modal_in()
	add_file_control_buttons_with_context(2)


func _on_file_3_button_pressed() -> void:
	current_file="file_3"
	set_file_info(3)
	animate_modal_in()
	add_file_control_buttons_with_context(3)


func _on_start_button_pressed() -> void:
	DataIO.save_slot=current_file
	DataIO.save_game()
	var scene = load("res://levels/main_level.tscn")
	get_tree().change_scene_to_packed(scene)


func animate_modal_in():
	$file_control_modal_panel.visible=true
	var anim:Tween=create_tween()
	anim.tween_property($file_control_modal_panel,"modulate:a",1,.15)


func add_file_control_buttons_with_context(file:int):
	var data_exists:bool=DataIO.save_data_exists(str(file))
	$file_info_panel/file_control_buttons.visible=true
	if data_exists:
		$file_info_panel/file_control_buttons/copy_button.visible=true
		$file_info_panel/file_control_buttons/delete_button.visible=true
		$file_info_panel/file_control_buttons/start_button.text="Load Save "+str(file)
		$file_info_panel/file_control_buttons/start_button.position=Vector2(32,11)
	else:
		$file_info_panel/file_control_buttons/copy_button.visible=false
		$file_info_panel/file_control_buttons/delete_button.visible=false
		$file_info_panel/file_control_buttons/start_button.text="Start New Game"
		$file_info_panel/file_control_buttons/start_button.position=Vector2(111,11)
		
	


func _on_modal_panel_button_pressed() -> void:
	reset_file_info_panel()
	$file_info_panel/file_control_buttons.visible=false
	$file_control_modal_panel.visible=false
	$file_control_modal_panel.modulate.a=0


#################### delete or copy ####################


func open_file_select_modal():
	$file_select_modal.visible=true


func open_confirm_panel_with_context(file:int):
	$file_select_modal/confirm_panel.visible=true
	
	var _mode="Delete " if delete_flag else "Copy "
	var title_text:String=_mode+"file "+str(file)+"?"
	if copy_flag:
		title_text=_mode+"file "+str(current_file).substr(len(str(current_file))-1,1)+"?"
	$file_select_modal/confirm_panel/confirm_container/title_text.text=title_text
	
	var body_text:String="Are you sure you want to [action] file [slot]?"
	if delete_flag:
		body_text="Are you sure you want to DELETE file "+str(file)+"?\nThis action is permenant."
	elif copy_flag:
		body_text="Are you sure you want to COPY file "+str(current_file).substr(len(str(current_file))-1,1)+"\nover file "+str(file)+"?"
	$file_select_modal/confirm_panel/confirm_container/body_text.text=body_text



func _on_file_select_1_button_pressed() -> void:
		open_confirm_panel_with_context(1)


func _on_file_select_2_button_pressed() -> void:
		open_confirm_panel_with_context(2)


func _on_file_select_3_button_pressed() -> void:
		open_confirm_panel_with_context(3)


func _on_copy_button_pressed() -> void:
	copy_flag=true
	open_file_select_modal()


func _on_delete_button_pressed() -> void:
	delete_flag=true
	open_file_select_modal()


func _on_file_select_modal_button_pressed() -> void:
	copy_flag=false
	delete_flag=false
	$file_select_modal.visible=false


func _on_confirm_panel_button_pressed() -> void:
	$file_select_modal/confirm_panel.visible=false


func _on_cancel_button_pressed() -> void:
	$file_select_modal/confirm_panel.visible=false
