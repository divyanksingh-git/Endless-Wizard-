class_name player

extends CharacterBody2D

@export var speed:int = 300
@export var acceleration:float = 0.3
@export var friction:float = 0.1
@export var health:int = 150

@onready var Idle = $"sprites/Idle-sheet"
@onready var Run = $"sprites/Run-sheet"
@onready var Death = $"sprites/Death-sheet"

@onready var sprite = $"sprites"
@onready var animation = $"AnimationPlayer"
@onready var flash = $"AnimationPlayer2"

@onready var hand = $"sprites/hand"
@onready var audio = $"AudioStreamPlayer2D"

@onready var healthbar = $"bar/TextureProgressBar"
@onready var scorel = $"hud/RichTextLabel"
@onready var shield = $"hud/TextureRect"

@onready var text = $"hud/RichTextLabel2"

var alive = true
var score = 0

func damageplayer(val):
	if health > 0:
		health -= val
		alive = true
		healthbar.value = health
		hand.set_status(true)
		flash.play("damage")
	else:
		alive = false
		hand.set_status(false)

func updatescore():
	score+=1
	scorel.text = "SCORE : "+str(score)
	
func toggleshield(status):
	if status == true:
		shield.show()
	if status ==false:
		shield.hide()
	
func _physics_process(_delta):
	var input = Vector2(Input.get_action_strength("right") - Input.get_action_strength("left"),
	Input.get_action_strength("down") - Input.get_action_strength("up"))
	
	if input == Vector2.LEFT or input == Vector2(-1,1) or input == Vector2(-1,-1):
		sprite.set("scale",Vector2(-1,1))
	if input == Vector2.RIGHT or input == Vector2(1,1) or input == Vector2(1,-1):
		sprite.set("scale",Vector2(1,1))
	input = input.normalized()
	if alive:
		if input != Vector2.ZERO:
			Idle.hide()
			Death.hide()
			Run.show()
			animation.playback_speed = 1
			animation.play("run")
			if audio.is_playing() == false:
				audio.play()
		
			velocity = lerp(Vector2.ZERO,input*speed,acceleration) # Acceleration
		else:
			Run.hide()
			Idle.show()
			Death.hide()
		
			animation.playback_speed = 0.5
			animation.play("idle")
			audio.stop()
			
			velocity = lerp(velocity,Vector2.ZERO,friction) # Friction
	else:
		velocity = Vector2.ZERO
		Idle.hide()
		Run.hide()
		Death.show()
		audio.stop()
		animation.play("death")
	move_and_slide()


func _on_animation_player_animation_finished(anim_name="death"):
	get_tree().change_scene_to_file("res://Level/Start.tscn")


func _on_timer_timeout():
	text.hide()
