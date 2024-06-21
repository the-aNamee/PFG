extends Node2D

signal die
signal apply_knockback(knockback: Vector2)

#@export var max_health = 0
@export var health = 0
@export var knockback_multiplyer = 1

func attack(strength: int, knockback: Vector2 = Vector2.ZERO):
	if !multiplayer.is_server():
		return
	
	health -= strength
	if health <= 0:
		health = 0
		if multiplayer.is_server():
			die.emit()
			return
	
	#Handle knockback
	var final_knockback = knockback * knockback_multiplyer
	apply_knockback.emit(final_knockback)
