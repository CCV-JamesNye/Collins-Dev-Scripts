extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_on_body_entered)
	pass # Replace with function body.

func _on_body_entered(body: Node2D) -> void:
	if body.name == "player1":
		body.die()
