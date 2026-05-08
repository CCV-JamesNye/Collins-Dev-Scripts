extends Control

@onready var start_game: Button = $MarginContainer/Panel/MarginContainer/VBoxContainer/start_game
@onready var resume_game: Button = $MarginContainer/Panel/MarginContainer/VBoxContainer/resume_game
@onready var quit_game: Button = $MarginContainer/Panel/MarginContainer/VBoxContainer/quit_game

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var index = SceneTransition.current_level_index
	var total_levels = SceneTransition.levels.size()
	if index == 0 or index >= total_levels:
		resume_game.disabled = true
	else:
		resume_game.disabled = false
	start_game.pressed.connect ( _start_game)
	resume_game.pressed.connect(_resume_game)
	quit_game.pressed.connect ( _quit_game)
	pass # Replace with function body.


func _quit_game () -> void:
	get_tree().quit()

func _resume_game () -> void:
	SceneTransition.restart_level()
	pass
	
func _start_game () -> void:
	SceneTransition.current_level_index=0
	SceneTransition.restart_level()
	pass
