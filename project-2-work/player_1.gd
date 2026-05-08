class_name player_1
extends CharacterBody2D

signal health_update (int)
signal player_hurt

var speed : float = 150
@export var gravity : float = 980.0
@export var jump_force : float = -400
@onready var hurt_box: Area2D = $"Hurt Box"
@onready var collect_sound: AudioStreamPlayer2D = $"Collectsound"
@onready var hurt_sound: AudioStreamPlayer2D = $"Hurt sound"
@onready var jump_sound: AudioStreamPlayer2D = $"Jump sound"
@onready var effect_player: AnimationPlayer = $"Effect Player"
@onready var hurt_overlay: CanvasLayer = $"../player_1/Hurt Box/hurt overlay"
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var swordhitbox: Area2D = $swordhitbox




var health : int = 5
var max_health : int = 5
var lives : int = 3
var is_attacking = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	health_update.emit(health) 
	hurt_box.take_damage.connect(_take_damage)
	GameManager.coin_pickup.connect( _play_coin_audio )
	animated_sprite_2d.animation_finished.connect(_on_animation_finished)
	$swordhitbox.area_entered.connect(_on_sword_hitbox_area_entered)
	pass # Replace with function body.

func _take_damage (damage: int) -> void:
	health -= damage
	printerr (health)
	hurt_overlay.screen_flash()
	player_hurt.emit()
	hurt_sound.play()
	health_update.emit( health )
	if health <= 0:
		die()

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity.y += gravity * delta
	if Input.is_action_just_pressed("Attack") and !is_attacking:
		start_attack()
	
	var direction : Vector2 = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		direction.x += 1
		animated_sprite_2d.flip_h = false
		$swordhitbox.scale.x = 1 
	elif Input.is_action_pressed("move_left"):
		direction.x -= 1
		animated_sprite_2d.flip_h = true
		$swordhitbox.scale.x = -1
		
	velocity.x = direction.x * speed 
	move_and_slide()
	
	if is_attacking:
		return # Do not let ground/air logic change the animation

	if !is_on_floor():
		if animated_sprite_2d.animation != "Jump":
			animated_sprite_2d.play("Jump")
	elif direction.x != 0:
		if animated_sprite_2d.animation != "Walking":
			animated_sprite_2d.play("Walking")
	else:
		if animated_sprite_2d.animation != "Idle":
			animated_sprite_2d.play("Idle")
				
func _unhandled_input(event: InputEvent) -> void:
		if event.is_action_pressed("jump") and is_on_floor():
			velocity.y = jump_force
			jump_sound.play()


func die () -> void:
	if GameManager.is_game_over():
		pass
	else:
		print ("Player Died")
		SceneTransition.load_scene(get_tree().current_scene.scene_file_path)

func _play_coin_audio() -> void:
	if $"Collectsound".is_playing():
		return
	$"Collectsound".play()

func start_attack():
	is_attacking = true
	$AnimationPlayer.play("Attack")
	await $AnimationPlayer.animation_finished
	is_attacking = false

func _on_animation_finished():
	if animated_sprite_2d.animation == "Attack":
		is_attacking = false
		
func _on_sword_hitbox_area_entered(area: Area2D) -> void: 
	print("PHYSICS TRIGGER: Sword touched ", area.name) 
	var enemy = area.owner if area.owner else area.get_parent()
	if enemy and enemy.is_in_group("enemies"):
		enemy.take_damage(1) 
