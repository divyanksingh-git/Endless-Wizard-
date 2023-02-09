extends Node2D

@onready var batscene = preload("res://Assets/Enemy/bat.tscn")
@onready var marker = $"Marker2D"
@onready var root = $".".get_parent().get_parent()
@onready var timer = $"Timer2"

var count = 0

func _on_timer_timeout():
	timer.start()

func _on_timer_2_timeout():
	if count <5:
		var bat = batscene.instantiate()
		root.get_parent().add_child(bat)
		bat.position = marker.global_position
		bat.playaudio()
		bat.playanimation()
		count += 1
	else:
		count = 0
		timer.stop()
