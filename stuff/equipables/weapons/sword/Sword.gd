extends Node2D

@onready var animation_player = $AnimationPlayer
@onready var collision_shape = $Area2D/CollisionShape2D

func _ready():
	$"..".activate.connect(slash)

func slash():
	animation_player.play("slash")
	if multiplayer.is_server():
		collision_shape.disabled = false


func _on_animation_finished(anim_name):
	animation_player.play("idle")
	
	if multiplayer.is_server() && anim_name == "slash":
		collision_shape.disabled = true
