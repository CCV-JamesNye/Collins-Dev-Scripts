extends CharacterBody2D


var speed : float = 25
@export var gravity : float = 980.0
@export var jump_force : float = -300
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var idle_sprite: Sprite2D = $"Idle Sprite"
@onready var walking_sprite: Sprite2D = $"Walking Sprite"



# Apply Movement


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
		
	# Store Direction
	var direction := Input.get_axis("move_left", "move_right")
	
	# Apply velocity
	if direction!= 0:
		velocity.x = direction * speed
		var is_flipped = direction < 0
		walking_sprite.flip_h = is_flipped
		idle_sprite.flip_h = is_flipped
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	update_visuals(direction)

	move_and_slide()
	
func update_visuals(direction: float) -> void:
	if direction != 0:
		animation_player.play("Walk")
		walking_sprite.visible = true
		idle_sprite.visible = false
	else:
		animation_player.play("Idle")
		walking_sprite.visible = false
		idle_sprite.visible = true
	
func _unhandled_input(event: InputEvent) -> void:
		if event.is_action_pressed("jump") and is_on_floor():
			velocity.y = jump_force

func die () -> void:
	print ("Player Died")
	get_tree().call_deferred("reload_current_scene")
	
