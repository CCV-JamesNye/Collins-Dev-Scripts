extends Area2D

@export var damage_amount: int = 1
var player_ref: player_1 = null  # Use your class_name here

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	$Timer.timeout.connect(_on_timer_timeout)

func _on_area_entered(area: Area2D):
	if area.owner is player_1:
		player_ref = area.owner
		apply_damage()
		$Timer.start()

func _on_area_exited(area: Area2D):
	if area.owner == player_ref:
		player_ref = null
		$Timer.stop()

func _on_timer_timeout():
	apply_damage()

func apply_damage():
	if player_ref:
		player_ref._take_damage(damage_amount)
