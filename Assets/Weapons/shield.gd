extends CharacterBody2D


@onready var animation = $"AnimationPlayer"

func _on_animation_player_animation_finished(anim_name = "shield"):
	get_parent().get_child(1).get_child(3).activeShield()
	queue_free()

func startanimation():
	animation.play("shield")
