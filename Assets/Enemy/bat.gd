class_name enemy
extends CharacterBody2D

const name_body = "enemy" 
var health = 100
var damageplayer = 10

var target = null
var entered = false

@export var speed:int = 50
@onready var timer = $"Timer"
@onready var audio = $"AudioStreamPlayer2D"
@onready var healthbar = $"bar/TextureProgressBar"
@onready var fly = $"AnimationPlayer"
@onready var flash = $"AnimationPlayer2"

@onready var batdeathscene = preload("res://Assets/Enemy/bat_death.tscn")
	
func get_name_body():
	return name_body
	
func playaudio():
	audio.play()
	
func playanimation():
	fly.play("fly")
	
func damage(val):
	health -= val
	healthbar.value = health
	flash.play("damage")
	if health <= 0:
		get_parent().get_child(0).updatescore()
		var batdeath = batdeathscene.instantiate()
		$".".get_parent().add_child(batdeath)
		batdeath.position = $".".global_position
		batdeath.audioplay()
		queue_free()
		
	
func _physics_process(delta):
	
	if entered == true and timer.is_stopped():
			timer.start()
	
	if target:
		velocity = global_position.direction_to(target.global_position).normalized() * speed
		move_and_slide()

	
func _on_area_2d_body_entered(body):
	if body.name == "Wizard":
		target = body


func _on_area_2d_body_exited(body):
	if body.name == "Wizard":
		target = null


func _on_area_2d_2_body_entered(body):
	if body.name == "Wizard":
		entered = true

func _on_area_2d_2_body_exited(body):
	if body.name == "Wizard":
		entered = false


func _on_timer_timeout():
	target.damageplayer(damageplayer)
	timer.stop()
