extends Camera2D

@export var player: Player
@onready var size: Vector2 = get_viewport_rect().size

func _ready() -> void:
	update_position()
	
func _physics_process(delta: float) -> void:
	update_position()

func update_position() -> void:
	var current_position: Vector2 = Vector2(player.global_position) / size
	global_position = current_position.floor() * size
	print(global_position)
