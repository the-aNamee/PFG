@tool
extends MultiplayerSpawner

@export var entities_to_spawn: Array[Node]
@export var reload_entities = false : set = reload_entities_now

func reload_entities_now(_nonsense):
	if !has_node(spawn_path):
		print("No entity folder provided.")
		reload_entities = false
		return
	
	var spawn_path_node = get_node(spawn_path)
	prints("Reloading", spawn_path_node.get_child_count(), "entities.")
	
	entities_to_spawn.clear()
	for entity in spawn_path_node.get_children():
		var packed_scene = PackedScene.new()
		packed_scene.pack(entity)
		entities_to_spawn.append(packed_scene.instantiate())
	
	reload_entities = false

func setup():
	if Engine.is_editor_hint():
		return
	
	#if !has_node(spawn_path):
		#print("No entity folder provided.")
		#reload_entities = false
		#return
	#
	#await get_tree().create_timer(5.0).timeout
	#
	#var spawn_path_node = get_node(spawn_path)
	#for unprepared_new_entity in entities_to_spawn:
		#if unprepared_new_entity.can_instantiate():
			#var new_entity = unprepared_new_entity.instantiate()
			#spawn_path_node.add_child(new_entity)
	#
	#print("Entities setup.")

#func _ready():
	#if Engine.is_editor_hint():
		#return
	#
	#if !has_node(spawn_path):
		#print("No entity folder provided.")
		#reload_entities = false
		#return
	#
	#remove_all_entities()

#func remove_all_entities():
	#var spawn_path_node = get_node(spawn_path)
	#for old_entity in spawn_path_node.get_children():
		#old_entity.queue_free()
