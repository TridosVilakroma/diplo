extends Control



func _ready() -> void:
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
	


func _process(delta: float) -> void:
	pass
