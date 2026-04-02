class_name player_1
extends CharacterBody2D

signal health_update (int)

var speed : float = 200
@export var gravity : float = 980.0
@export var jump_force : float = -400
@onready var hurt_box: Area2D = $"Hurt Box"


var health : int = 3
var max_health : int = 3



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hurt_box.take_damage.connect(_take_damage)
	pass # Replace with function body.

func _take_damage (damage: int) -> void:
	health -= damage
	printerr (health)
	health_update.emit( health )
	if health <= 0:
		die()

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
	SceneTransition.load_scene(get_tree().current_scene.scene_file_path)
