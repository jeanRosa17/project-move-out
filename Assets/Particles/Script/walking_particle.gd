extends Node2D

@export var min_speed: float = 10.0  

@export var player: Player
@onready var dust: CPUParticles2D = $CPUParticles2D

func _process(_delta: float) -> void:
	if player == null:
		return
	var vel: Vector2 = player.velocity
	if vel.length() > min_speed:
		# Player is moving
		#print("yes")
		dust.emitting = true

		# Point the dust opposite the direction of movement
		# vel.angle() is direction of movement, +PI flips it
		dust.global_rotation = vel.angle() + PI
	else:
		#print("no")
		# Player is standing still → no dust
		dust.emitting = false
