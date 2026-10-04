extends Node

signal toast_notification(message_to_emit:String)

func toast(message:String):
	print(message)
	toast_notification.emit(message)
