extends CanvasLayer
@onready var color_rect: ColorRect = $ColorRect
@onready var check_box: CheckBox = $CheckBox
@onready var check_box_2: CheckBox = $CheckBox2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.modulate=Color(1,1,1,0)
	color_rect.visible=false
	check_box.toggled.connect(mute_music)
	check_box.button_pressed = true
	check_box.release_focus()
	check_box_2.toggled.connect(mute_sfx)
	check_box_2.button_pressed = true
	check_box_2.release_focus()
	pass # Replace with function body.

func screen_flash () -> void:
	color_rect.visible=true
	var tween = create_tween()
	tween.tween_property(color_rect,"modulate",Color(1,1,1,1),0.1)
	await tween.finished 
	var tween2 = create_tween()
	tween2.tween_property(color_rect,"modulate",Color(1,1,1,0),0.3)
	await tween2.finished 

func mute_music (toggled_on:bool) -> void:
	if toggled_on:
		AudioManager.mute_music(false)
	else:
		AudioManager.mute_music(true)
	check_box.release_focus()
	pass

func mute_sfx (toggled_on:bool) -> void:
	if toggled_on:
		AudioManager.mute_sfx(false)
	else:
		AudioManager.mute_sfx(true)
	check_box_2.release_focus()
	pass
