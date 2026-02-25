extends CharacterBody2D

@onready var state_label: Label = $"State Label"


var speed : float = 400
@export var gravity : float = 980.0
@export var jump_force : float = -400

# Apply Movement


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	state_label.text = str(is_on_floor())
	pass

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
	# Store Direction
	var direction : Vector2 = Vector2.ZERO

	# Read input
	if Input.is_action_pressed("move_right"):
		direction.x += 1
	if Input.is_action_pressed("move_left"):
		direction.x -= 1
	
	velocity.x = direction.normalized().x * speed
	move_and_slide()
func _unhandled_input(event: InputEvent) -> void:
		if event.is_action_pressed("jump") and is_on_floor():
			velocity.y = jump_force


func die () -> void:
	print ("Player Died")
	get_tree().call_deferred("reload_current_scene")
