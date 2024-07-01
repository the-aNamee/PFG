extends Node

@export var spawn_location: Node

func setup():
	await get_tree().create_timer(5).timeout
	for entity_spawner: Node2D in get_children():
		var packed: PackedScene = entity_spawner.entity_scene
		if packed != null && packed.can_instantiate():
			var new_entity: Node2D = packed.instantiate()
			new_entity.global_position = entity_spawner.global_position
			spawn_location.add_child(new_entity, true)
		entity_spawner.hide()

func _ready():
	if !multiplayer.is_server():
		for node: Node2D in get_children():
			node.hide()
