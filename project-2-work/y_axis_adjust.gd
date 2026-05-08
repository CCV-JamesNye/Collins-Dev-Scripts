extends Parallax2D

@export var sink_speed: float = 0.5
@export var start_height_offset: float = 200.0 # Adjust this to push it down at the start
var last_camera_y: float = 0.0
var total_sink: float = 0.0
@onready var camera = get_viewport().get_camera_2d()

func _ready():
	ignore_camera_scroll = true 
	if camera:
		last_camera_y = camera.get_screen_center_position().y

func _process(_delta):
	if not camera:
		camera = get_viewport().get_camera_2d()
		return
		
	var cam_center = camera.get_screen_center_position()
	
	screen_offset.x = -cam_center.x * (scroll_scale.x - 1.0)
	
	if cam_center.y > last_camera_y:
		total_sink += (cam_center.y - last_camera_y) * sink_speed
	
	screen_offset.y = start_height_offset + total_sink
	
	last_camera_y = cam_center.y
