extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect( _check_for_win )
	pass # Replace with function body.

func _check_for_win (body : Node2D) -> void:
	if body is player_1:
		if body_entered.is_connected(_check_for_win):
			body_entered.disconnect(_check_for_win)
		SceneTransition.go_to_next_level()
