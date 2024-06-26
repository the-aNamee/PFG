extends CharacterBody2D


@onready var input = $PlayerInput
@onready var art = $Art
@onready var weapon = $Art/Weapon

@onready var camera = $Camera2D



const SPEED = 100.0
const FRICTION = 0.75
const JUMP_VELOCITY = -400.0

var current_friction: float

@export var player_id = 1 :
	set(id):
		player_id = id
		$PlayerInput.set_multiplayer_authority(id)

@export var can_turn_around = true
var knockbacking = false :
	set(new):
		if new:
			current_friction = 1.0
		else:
			current_friction = FRICTION
		knockbacking = new

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _ready():
	if player_id == multiplayer.get_unique_id():
		$Camera2D.make_current()

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	# Handle jump.
	if input.jumping && is_on_floor():
		velocity.y = JUMP_VELOCITY
	input.jumping = false
	
	# Handle action.
	if input.action_1ing && !knockbacking:
		weapon.use()
	input.action_1ing = false
	
	
	velocity.x = velocity.x * current_friction
	if !knockbacking:
		velocity.x += input.direction * SPEED
	
	if input.direction > 0 && can_turn_around:
		$Art.scale.x = 1
	elif input.direction < 0 && can_turn_around:
		$Art.scale.x = -1
	
	move_and_slide()
	
	if is_on_floor():
		knockbacking = false

func _on_death():
	queue_free()


func _apply_knockback(knockback):
	if knockback:
		velocity = knockback
		knockbacking = true
		await get_tree().process_frame
