extends Node

@export var strength = 1

const HealthSystemScript = preload("res://stuff/systems/health system/health_system.gd")

func hit(body: CollisionObject2D):
	for node in body.get_children():
		var script = node.get_script()
		if script == HealthSystemScript:
			node.attack(strength)
