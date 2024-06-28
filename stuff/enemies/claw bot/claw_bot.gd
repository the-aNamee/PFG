extends CharacterBody2D



@onready var art = $Art

const SPEED = 50.0
const FRICTION = 0.75


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction = 1
var knockbacking = false
var can_stop_knockbacking = true

func _ready():
	NetworkTime.on_tick.connect(tick)

func tick(delta, _tick):
	if is_on_wall():
		direction = -direction
	
	# Add the gravity.
	if !is_on_floor():
		velocity.y += gravity * delta
	
	if !knockbacking:
		velocity.x = velocity.x * FRICTION
		velocity.x += direction * SPEED
		
		if direction > 0:
			art.scale.x = 1
		elif direction < 0:
			art.scale.x = -1
	
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
