extends Node


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func mute_music (status:bool) -> void:
	var bus = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_mute(bus,status)
	pass
	
func mute_sfx (status:bool) -> void:
	var bus = AudioServer.get_bus_index("SFX")
	AudioServer.set_bus_mute(bus,status)
	pass
	
