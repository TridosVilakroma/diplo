extends Control

var start_pressed    : bool=false
var initiated        : bool=false
var time             : float=0.0
var press_start_size : int=30
var bounce_anim      : Tween

func _ready() -> void:
	bounce_anim=create_tween().set_loops()
	bounce_anim.set_ease(Tween.EASE_OUT)
	bounce_anim.set_trans(Tween.TRANS_BOUNCE)
	bounce_anim.tween_property(self,"press_start_size",50,1.5)
	bounce_anim.tween_property(self,"press_start_size",30,1.25)


func _process(delta: float) -> void:
	time+=delta
	$press_start_text.add_theme_font_size_override("bold_font_size",press_start_size)
	if start_pressed and not initiated:
		initiated=true
		bounce_anim.stop()
		var center_anim:Tween=create_tween()
		center_anim.tween_property(
			$press_start_text,
			"global_position",
			Vector2.ZERO,
			1.15)
		var expand_anim:Tween=create_tween()
		expand_anim.tween_property(self,"press_start_size",275,1.25)
		var fade_anim:Tween=create_tween()
		fade_anim.tween_property($press_start_text,"modulate:a",0,1)
		var title_move_anim:Tween=create_tween()
		title_move_anim.tween_property(
			$title_panel,
			"global_position:x",
			get_viewport_rect().size[0]-$title_panel.size[0]-get_viewport_rect().size[0]/40,
			1)
		await title_move_anim.finished
		get_tree().root.add_child(load("res://scenes/main_menu.tscn").instantiate())


func _input(event: InputEvent) -> void:
	if event.is_action_released('select_option'):
		start_pressed=true
	if event is InputEventMouseButton:
		start_pressed=true
