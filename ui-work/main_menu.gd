extends Control

@onready var start_game: Button = $MarginContainer/Panel/MarginContainer/VBoxContainer/start_game
@onready var quit_game: Button = $MarginContainer/Panel/MarginContainer/VBoxContainer/quit_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_game.pressed.connect ( _start_game)
	quit_game.pressed.connect ( _quit_game)
	await SceneTransition.fade_in()
	pass # Replace with function body.


func _quit_game () -> void:
	get_tree().quit()

func _start_game () -> void:
	await SceneTransition.fade_to_black()
	get_tree().change_scene_to_file("res://Week 5 Visuals Work/week-5-visuals/visuals_prime.tscn")
	
