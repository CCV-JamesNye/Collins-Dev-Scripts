  
extends CanvasLayer

@onready var animation_player: AnimationPlayer = $Control/AnimationPlayer

func fade_to_black () -> bool:
	animation_player.play("Fade to black")
	await animation_player.animation_finished
	return true

func fade_in() -> bool:
	animation_player.play("fade in")
	await animation_player.animation_finished
	return true

func load_scene (new_scene : String) -> void:
	get_tree().paused = true
	await fade_to_black()
	get_tree().change_scene_to_file( new_scene )
	await fade_in( )
	get_tree().paused = false
