extends Node

signal die

#@export var max_health = 0
@export var health = 0

func attack(strength: int):
	health -= strength
	if health <= 0:
		health = 0
		if multiplayer.is_server():
			die_rpc()

#@rpc()
func die_rpc():
	die.emit()
