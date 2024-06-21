@tool
extends Marker2D

@export var entity_scene: PackedScene :
	set(_new):
		entity_scene = _new
		entity_name = "Not this."
@export var entity_name: String = "" :
	set(_nonsense):
		if entity_scene != null && entity_scene.can_instantiate():
			entity_name = entity_scene.instantiate().name
		else:
			entity_name = "Blank"
		name = entity_name + "SpawnerPos"
		$Label.text = entity_name
