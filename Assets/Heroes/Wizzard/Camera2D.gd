extends Camera2D

@export var randomshakeStrength: float = 1
@export var shakeDecay:float = 2
@onready var camera = $"."
@onready var rand = RandomNumberGenerator.new()

var shakeStrength:float = 0.0

func shake():
	shakeStrength = randomshakeStrength

func _process(delta):
	shakeStrength = lerp(shakeStrength,0.0,shakeDecay*delta)
	camera.offset = get_random_offset()

func  get_random_offset():
	return Vector2(
		rand.randf_range(-shakeStrength,shakeStrength),
		rand.randf_range(-shakeStrength,shakeStrength)
	)
