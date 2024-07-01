class_name PlayerInput extends Node

var input_jump = false
var input_action_1: Vector2 = Vector2.INF

@export var direction = 0

func _ready():
	NetworkTime.before_tick_loop.connect(gather)



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
	
	
	input_action_1 = Input.is_action_pressed("action_1_left")
