extends Control



func _ready() -> void:
	animate_entry()


func animate_entry():
	var _button_pause:float=0.0
	for _button:Button in $buttons_container.get_children():
		_button_pause+=0.15
		_button.scale.y=0
		_button.pivot_offset=_button.size/2
		var anim:Tween=create_tween()
		anim.tween_interval(_button_pause)
		anim.tween_property(_button,"scale:y",1,.1)
		anim.tween_property(_button,"scale:y",-1,.2)
		anim.tween_property(_button,"scale:y",1,.2)


func _on_play_button_pressed() -> void:
	get_tree().root.add_child(load("res://scenes/play_scene.tscn").instantiate())


func _on_settings_button_pressed() -> void:
	pass # Replace with function body.


func _on_credit_button_pressed() -> void:
	get_tree().root.add_child(load("res://scenes/credits_scene.tscn").instantiate())


func _on_quit_button_pressed() -> void:
	get_tree().quit()
