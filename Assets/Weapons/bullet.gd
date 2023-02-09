class_name attack
extends CharacterBody2D


var speed = 150
@onready var sprite = $"AnimatedSprite2D"
@onready var area = $"Area2D"
@onready var audio = $"AudioStreamPlayer2D"
@onready var explosionscene = preload("res://Assets/Weapons/explosion.tscn")
@onready var timer = $"Timer2"

@export var damage:int = 20

func  _physics_process(delta):
	velocity = velocity.normalized()*speed
	var col = move_and_collide(velocity*delta)
	
	if col:
		var entities = get_node("Area2D").get_overlapping_bodies()
		for i in entities:
			if i.get_name_body() == "enemy":
				i.damage(damage)
				var explosion = explosionscene.instantiate()
				$".".get_parent().add_child(explosion)
				explosion.position = $".".global_position
				audio.stop()
				explosion.playaudio()
				shake()
				queue_free()


func shake():
	get_parent().get_child(0).get_child(3).shake()

func playaudio():
	audio.play()
	timer.start()
	
func _on_timer_timeout():
	queue_free()

func _on_timer_2_timeout():
	audio.stop()
