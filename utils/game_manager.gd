extends Node

signal toast_notification(message_to_emit:String)

var settings:ConfigFile

func _ready() -> void:
	settings=DataIO.load_config_file()



func toast(message:String):
	toast_notification.emit(message)
