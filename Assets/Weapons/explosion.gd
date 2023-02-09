extends AnimatedSprite2D


@onready var audio = $"AudioStreamPlayer2D"

func playaudio():
	audio.play()
	
	
func _on_animation_finished():
	queue_free()
