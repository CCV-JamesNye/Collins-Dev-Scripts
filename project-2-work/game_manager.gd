extends Node

var lives : int = 3
var coins : int = 0

func is_game_over() -> bool:
	coins = 0
	lives -= 1
	print("Lives Left" + str(lives))
	if lives <= 0:
		SceneTransition.load_scene("res://Transition/game_over.tscn")
		reset_game()
		return true
	return false

func coin_collected () -> void:
	coins += 1
	if coins >= 3:
		SceneTransition.load_scene("res://Transition/Victory_screen.tscn")
		reset_game()


func reset_game() -> void:
	lives = 3
	coins = 0
