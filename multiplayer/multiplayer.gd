extends Node

const PORT = 4433

func _ready():
	get_tree().paused
	multiplayer.server_relay = false
	
	if DisplayServer.get_name() == "headless":
		print("Automatically starting dedicated server.")
		_on_host_pressed.call_deferred()


func _on_host_pressed():
	var peer = ENetMultiplayerPeer.new()
	peer.create_server(PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start server")
		return
	multiplayer.multiplayer_peer = peer
	start_game()


func _on_connect_pressed():
	var txt = $UI/Net/Options/Remote.text
	if txt == "":
		OS.alert("Yea... No...")
		return
	var peer = ENetMultiplayerPeer.new()
	peer.create_client(txt, PORT)
	if peer.get_connection_status() == MultiplayerPeer.CONNECTION_DISCONNECTED:
		OS.alert("Failed to start multiplayer client.")
	multiplayer.multiplayer_peer = peer
	start_game()

func start_game():
	$UI.hide()
	get_tree().paused = false
	
	if multiplayer.is_server():
		change_scene.call_deferred(load("res://scenes/level_0.tscn"))


func change_scene(scene: PackedScene):
	var level = $Level
	for c in level.get_children():
		level.remove_child(c)
		c.queue_free()
	
	level.add_child(scene.instantiate())

func _input(event):
	if !multiplayer.is_server():
		return
	if event.is_action_pressed("reset"):
		change_scene.call_deferred(load("res://scenes/level_0.tscn"))
