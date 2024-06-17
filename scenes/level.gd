extends Node2D


@onready var player_folder = $Players

const SPAWN_RANDOM = 430 - 40

func _ready():
	if !multiplayer.is_server():
		return
	
	multiplayer.peer_connected.connect(add_player)
	multiplayer.peer_disconnected.connect(del_player)
	
	for id in multiplayer.get_peers():
		add_player(id)
	
	#if !OS.has_feature("dedicated_server"):
		#add_player(1)


func add_player(id: int):
	var character = preload("res://stuff/player/player.tscn").instantiate()
	character.player_id = id
	character.position = Vector2(40 + randf() * SPAWN_RANDOM, 360)
	character.name = str(id)
	player_folder.add_child(character, true)


func del_player(id: int):
	if !player_folder.has_node(str(id)):
		return
	player_folder.get_node(str(id)).queue_free()
