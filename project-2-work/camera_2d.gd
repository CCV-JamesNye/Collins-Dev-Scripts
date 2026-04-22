extends Camera2D

@export var player : player_1 = null
@export var shake_max_offset : float = 5.0
@export var shake_decay : float = 1.0
@export var shake_trauma : float = 0
@export_range(0,1,0.05, "or greater") var shake_power : float= 0.5





# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if player:
		player.player_hurt.connect(shake_camera)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if shake_trauma > 0:
		shake_trauma = max (shake_trauma - shake_decay * delta, 0)
		shake()
	pass

func shake_camera (value : float = 1.0) -> void:
	shake_trauma = value
	pass

func shake () -> void:
	var amount : float = pow( shake_trauma * shake_power, 2)
	offset = Vector2 (randf_range(-1,1), randf_range(-1,1) * shake_max_offset * amount )
