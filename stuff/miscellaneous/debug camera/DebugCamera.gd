extends Camera2D

const SPEED = 0.1
var activated = false

func _ready():
	if !multiplayer.is_server():
		return
	enabled = true

func _process(_delta):
	if !multiplayer.is_server():
		return
	
	if Input.is_action_just_pressed("pause"):
		activated = !activated
		if activated:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
		else:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
	if activated:
		position += Input.get_last_mouse_velocity() * SPEED
