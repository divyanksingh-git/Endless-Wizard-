extends Node2D

@onready var bulletres = preload("res://Assets/Weapons/bullet.tscn")
@onready var shieldres = preload("res://Assets/Weapons/shield.tscn")

@onready var root = $".".get_parent().get_parent()

var can_shoot:bool = true
var alive = true
var shielduse = true

func _physics_process(delta):
	look_at(get_global_mouse_position())
	
	if Input.is_action_just_pressed("shoot") and can_shoot and alive:
		var bullet = bulletres.instantiate()
		root.get_parent().add_child(bullet)
		bullet.position = $bulletpoint.global_position
		bullet.velocity = get_global_mouse_position() - bullet.position
		bullet.look_at(get_global_mouse_position())
		bullet.playaudio()
	
	if Input.is_action_just_pressed("power") and alive and shielduse:
		var shield = shieldres.instantiate()
		root.add_child(shield)
		shield.startanimation()
		shielduse=false
		root.toggleshield(shielduse)
		

func activeShield():
	shielduse = true
	root.toggleshield(shielduse)

func set_status(status):
	alive = status

func _on_area_2d_mouse_entered():
	can_shoot = false

func _on_area_2d_mouse_exited():
	can_shoot = true
