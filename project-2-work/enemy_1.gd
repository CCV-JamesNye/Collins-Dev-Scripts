extends CharacterBody2D

signal health_update(current_health: int)

@export var patrol_speed : float = 30.0
@export var chase_speed_multiplier : float = 2
@export var gravity : float = 980.0
@onready var floor_detector: RayCast2D = $"floor detector"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var detection_range: Area2D = $"detection range"
@onready var chase_timer: Timer = $ChaseTimer
@onready var idle_timer: Timer = $IdleTimer
@export var max_health: int = 3
@onready var progress_bar: ProgressBar = $"hurt box/ProgressBar"
@onready var hurt_box: Area2D = $"hurt box"

var health: int = 3
var direction : Vector2 = Vector2.RIGHT
var is_dead : bool = false

enum STATE {IDLE, PATROL, CHASE}

var current_state : STATE = STATE.IDLE

func _ready() -> void:
	$"hurt box".area_entered.connect(_on_hurtbox_area_entered)
	add_to_group("enemies")
	if progress_bar:
		progress_bar.max_value = max_health
		progress_bar.value = health
	detection_range.body_entered.connect( _check_for_player)
	detection_range.body_exited.connect( _player_left )
	chase_timer.timeout.connect ( _stop_chasing )
	idle_timer.timeout.connect(_start_patrol)
	idle_timer.start()
	
func _physics_process(delta: float) -> void:
	if is_dead:
		return
		
	if not is_on_floor():
		velocity.y += gravity * delta
		
	match current_state:
		STATE.IDLE:
			handle_idle()
		STATE.PATROL:
			handle_patrol()
		STATE.CHASE:
			handle_chase()
			
	move_and_slide()

	if is_on_wall():
		var normal = get_wall_normal()
		if abs(normal.x) > 0.9:
			flip_direction()
	if is_on_floor() and not floor_detector.is_colliding():
		flip_direction()

func flip_direction():
	if direction == Vector2.RIGHT:
		direction = Vector2.LEFT
		floor_detector.position.x = -6
		animated_sprite_2d.flip_h = true
	else:
		direction = Vector2.RIGHT
		floor_detector.position.x = 6
		animated_sprite_2d.flip_h = false
	global_position.x += direction.x * 2

func handle_idle() -> void:
	velocity.x = 0
	animated_sprite_2d.play("Idle")
	pass

func handle_patrol() -> void:
	animated_sprite_2d.play("Walking")
	velocity.x=direction.x* (patrol_speed + chase_speed_multiplier)
	pass

func handle_chase () -> void:
	animated_sprite_2d.play("Walking")
	velocity.x=direction.x * (patrol_speed * 3)
	pass
	
func _check_for_player (body : Node2D) -> void:
	if body is player_1:
		current_state = STATE.CHASE
		chase_timer.stop()
		idle_timer.stop()

func _player_left (body : Node2D) -> void:
	if body is player_1:
		if is_inside_tree() and chase_timer.is_inside_tree():
			chase_timer.start()

func _stop_chasing () -> void:
	current_state = STATE.IDLE
	idle_timer.start()
	
func _start_patrol () -> void:
	current_state = STATE.PATROL

func take_damage(amount: int):
	if is_dead: return
	if progress_bar:
		progress_bar.value = health
	health -= amount
	health_update.emit(health)
	if health <= 0:
		is_dead = true
		die()

func die():
	velocity = Vector2.ZERO
	is_dead = true
	if progress_bar:
		progress_bar.value = health
		health_update.emit(health)
	if hurt_box: 
		hurt_box.set_deferred("monitoring", false)
		hurt_box.set_deferred("monitorable", false)
	if animated_sprite_2d.sprite_frames.has_animation("Death"):
		animated_sprite_2d.play("Death")
		await animated_sprite_2d.animation_finished
		queue_free()

func _on_hurtbox_area_entered(area: Area2D) -> void:
	print("Something entered the enemy's hurtbox!")
