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
