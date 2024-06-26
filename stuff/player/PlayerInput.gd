extends MultiplayerSynchronizer

@export var jumping = false
@export var action_1ing = false

@export var direction = 0

func _ready():
	set_process(get_multiplayer_authority() == multiplayer.get_unique_id())

@rpc()
func jump():
	jumping = true

@rpc()
func action_1():
	server_confirm.rpc()
	if multiplayer.is_server():
		action_1ing = true

@rpc("any_peer")
func server_confirm() -> void:
	action_1ing = true

func _process(_delta):
	direction = Input.get_axis("move_left", "move_right")
	if Input.is_action_just_pressed("jump"):
		jump.rpc()
	if Input.is_action_just_pressed("action 1"):
		action_1.rpc_id(1)
