@icon("res://assets/editor icons/hit_system.svg")
extends Node2D

@export var strength = 1
@export var knockback: float
@export var vertical_knockback: float

const HealthSystemScript = preload("res://stuff/systems/health system/health_system.gd")

func hit(body):
	for node in body.get_children():
		var script = node.get_script()
		if script == HealthSystemScript:
			var dir = float_norm(node.global_position.x - global_position.x)
			var full_knockback = Vector2(dir * knockback, -vertical_knockback)
			node.attack(strength, full_knockback)

func float_norm(input):
	if input > 0:
		return 1
	elif input < 0:
		return -1
	else:
		return 0
