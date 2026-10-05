extends Node

var config = ConfigFile.new()

func _ready() -> void:
	# Create new ConfigFile object.
	var config = ConfigFile.new()


func load_settings():
	# Load data from a file.
	var err = config.load("user://data/settings.ini")

	# If the file didn't load, ignore it.
	if err != OK:
		return
