extends CPUParticles2D

@export var min_speed: float = 10.0  

var player: CharacterBody2D
func _ready() -> void:
	var node: Node = get_parent()
	while node:
		if node is CharacterBody2D:
			player = node
			break
		node = node.get_parent()

	if player == null:
		push_warning("DustParticles: Could not find a player")


func _process(delta: float) -> void:
	if player == null:
		return
	var vel: Vector2 = player.velocity
	if vel.length() > min_speed:
		# Player is moving
		print("yes")
		emitting = true

		# Point the dust opposite the direction of movement
		# vel.angle() is direction of movement, +PI flips it
		global_rotation = vel.angle() + PI
	else:
		print("no")
		# Player is standing still → no dust
		emitting = false
