class_name HurtBox extends Area2D
#Area for taking damage from other sources

signal take_damage (int)
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(_take_damage)
	pass # Replace with function body.

func _take_damage(_area : Area2D) -> void:
	if _area is HitBox:
		take_damage.emit(_area.damage)
