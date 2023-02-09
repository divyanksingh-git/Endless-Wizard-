extends Control



func _on_button_pressed():
	print_debug("pressed")
	get_tree().change_scene_to_file("res://Level/level.tscn")
