class_name PlayerInput extends Node

var input_jump = false


#@export var jumping = false
@export var action_1ing = false

@export var direction = 0

func _ready():
	NetworkTime.before_tick_loop.connect(gather)

#@rpc()
#func jump():
	#jumping = true

@rpc()
func action_1():
	server_confirm.rpc()
	if multiplayer.is_server():
		action_1ing = true

@rpc("any_peer")
func server_confirm() -> void:
	action_1ing = true

func gather():
	if !is_multiplayer_authority():
		return
	direction = Input.get_axis("move_left", "move_right")
	#if Input.is_action_just_pressed("jump"):
		#jump.rpc()
	#if Input.is_action_just_pressed("action 1"):
		#action_1.rpc_id(1)


func _process(_delta):
	if !is_multiplayer_authority():
		return
	input_jump = Input.is_action_pressed("jump")
