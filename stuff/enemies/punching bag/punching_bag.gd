extends CharacterBody2D

func _on_death():
	queue_free()
