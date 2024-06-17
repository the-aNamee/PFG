extends CharacterBody2D


@onready var input = $PlayerInput

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@export var player_id = 1 :
	set(id):
		player_id = id
		$PlayerInput.set_multiplayer_authority(id)


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if player_id == multiplayer.get_unique_id():
		$Camera2D.make_current()
	
	#set_physics_process(multiplayer.is_server())

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if input.jumping and is_on_floor():
		velocity.y = JUMP_VELOCITY
	input.jumping = false
	
	# Get the input direction and handle the movement/deceleration.
	var direction = input.direction
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	move_and_slide()
