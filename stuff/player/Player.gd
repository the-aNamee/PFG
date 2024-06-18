extends CharacterBody2D


@onready var input = $PlayerInput
@onready var art = $Art
@onready var animation_player = $Art/AnimationPlayer

const SPEED = 100.0
const FRICTION = 0.75
const JUMP_VELOCITY = -400.0

@export var player_id = 1 :
	set(id):
		player_id = id
		$PlayerInput.set_multiplayer_authority(id)


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if player_id == 1:
		queue_free()
	
	
	if player_id == multiplayer.get_unique_id():
		$Camera2D.make_current()
	
	#set_physics_process(multiplayer.is_server())

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if input.jumping && is_on_floor():
		velocity.y = JUMP_VELOCITY
	input.jumping = false
	
	# Handle action.
	if input.action_1ing && is_on_floor():
		print("Slashing")
		animation_player.play("slash")
	input.action_1ing = false
	
	# Get the input direction and handle the movement/deceleration.
	velocity.x = velocity.x * FRICTION
	velocity.x += input.direction * SPEED
	
	if input.direction > 0:
		$Art.scale.x = 1
	elif input.direction < 0:
		$Art.scale.x = -1
	
	move_and_slide()
