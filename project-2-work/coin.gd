extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(_coin_collected)
	pass # Replace with function body.

func _coin_collected (body: Node2D ) -> void:
	if body is player_1:
		GameManager.coin_collected()
		queue_free()
