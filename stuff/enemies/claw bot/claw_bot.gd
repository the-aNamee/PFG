extends CharacterBody2D



@onready var art = $Art

const SPEED = 50.0
const FRICTION = 0.75
const JUMP_VELOCITY = -400.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction = 1

func _physics_process(delta):
	if is_on_wall():
		direction = -direction
	
	# Add the gravity.
	if !is_on_floor():
		velocity.y += gravity * delta
	
	# Get the input direction and handle the movement/deceleration.
	velocity.x = velocity.x * FRICTION
	velocity.x += direction * SPEED
	
	if direction > 0:
		art.scale.x = 1
	elif direction < 0:
		art.scale.x = -1
	
	move_and_slide()


func _on_death():
	queue_free()
