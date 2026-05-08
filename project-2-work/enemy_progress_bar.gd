extends ProgressBar


@onready var enemy1: CharacterBody2D = $"../.."

func _ready() -> void:
	enemy1.health_update.connect ( _update_bar)
	pass

func _update_bar (health : int ) -> void:
	value = health
