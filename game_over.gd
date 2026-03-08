extends CanvasLayer

@onready var main_menu_return: Button = $"Control/MarginContainer/VBoxContainer/Main Menu Return"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	main_menu_return.pressed.connect( _menu )
	pass # Replace with function body.

func _menu() -> void:
	await SceneTransition.fade_to_black()
	get_tree().change_scene_to_file("res://ui-work/main_menu.tscn")
	
