extends CanvasLayer
@onready var color_rect: ColorRect = $ColorRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.modulate=Color(1,1,1,0)
	pass # Replace with function body.

func screen_flash () -> void:
	var tween = create_tween()
	tween.tween_property(color_rect,"modulate",Color(1,1,1,1),0.1)
	await tween.finished 
	var tween2 = create_tween()
	tween2.tween_property(color_rect,"modulate",Color(1,1,1,0),0.3)
	await tween2.finished 
