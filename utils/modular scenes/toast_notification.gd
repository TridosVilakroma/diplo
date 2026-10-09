extends Control

# Adjust the speed of the scroll (pixels per second)
@export var scroll_speed: float = 150.0

@onready var panel: Panel = $clipping_node/Panel
@onready var text: RichTextLabel = $clipping_node/Panel/RichTextLabel

# Store the starting X position of the label
var start_x: float
var queue:Array=[]
var pushed:bool=false

func _ready() -> void:
	$clipping_node.clip_contents=true
	GameManager.toast_notification.connect(push)

func _process(delta: float) -> void:
	if pushed:scroll_text(delta)
	if queue.size()<=0:return
	if pushed:return
	var msg=queue.pop_front()
	_push(msg)

func scroll_text(delta: float):
	# Scroll left.
	text.position.x -= scroll_speed * delta
	# Right edge of the actual text.
	var text_right_edge := text.position.x + text.get_visible_content_rect().size.x
	# Once the entire text has passed the left side,
	# put it back on the right.
	if text_right_edge < 0.0:
		text.position.x = panel.position.x+panel.size.x


func push(msg:String):
	print(msg)
	queue.append(msg)


func _push(msg):
	pushed=true
	text.text=msg
	text.set_position(Vector2.ZERO+Vector2(panel.size.x,0),true)
	panel.modulate.a=1
	panel.set_position(Vector2(-600,16),true)

	
	var anim_slide_in:Tween=create_tween()
	anim_slide_in.set_trans(Tween.TRANS_EXPO)
	anim_slide_in.tween_property(panel,"position",Vector2(40,16),1)
	await anim_slide_in.finished
	ComFuncs.set_anchors_to_current_ratio(panel)
	
	await get_tree().create_timer(5).timeout
	
	var anim_slide_out:Tween=create_tween()
	anim_slide_out.set_trans(Tween.TRANS_EXPO)
	anim_slide_out.tween_property(panel,"position",Vector2(1152,16),1.5)
	
	var anim_fade_out:Tween=create_tween()
	anim_fade_out.tween_property(panel,"modulate:a",.3,1.5)
	

	await anim_fade_out.finished
	pushed=false
