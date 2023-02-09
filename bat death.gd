extends Node2D

@onready var audio = $"AudioStreamPlayer2D"
@onready var timer = $"Timer"

func audioplay():
	audio.play()
	timer.start()
	print_debug(audio.stream.get_length())


func _on_animated_sprite_2d_animation_finished():
	queue_free()


func _on_timer_timeout():
	audio.stop()
