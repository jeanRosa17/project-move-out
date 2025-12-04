# PossessedFurniture.gd
extends Node2D

@export var move_offset: Vector2 = Vector2(40, 0)
# How far from the starting position the chair should move.
@export var move_speed: float = 80.0
# Pixels per second
@export var wait_time: float = 0.5
# How long (in seconds) the chair waits at each end
var _start_position: Vector2
var _end_position: Vector2
var _state: String = "moving_to_end"
var _wait_timer: float = 0.0
var _active: bool = true 

func _ready() -> void:
	_start_position = global_position
	_end_position = _start_position + move_offset

	add_to_group("possessed_furniture")


func _physics_process(delta: float) -> void:
	if not _active:
		return

	match _state:
		"moving_to_end":
			_move_towards(_end_position, delta, "waiting_at_end", "moving_to_start")
		"moving_to_start":
			_move_towards(_start_position, delta, "waiting_at_start", "moving_to_end")
		"waiting_at_end", "waiting_at_start":
			_wait_timer -= delta
			if _wait_timer <= 0.0:
				if _state == "waiting_at_end":
					_state = "moving_to_start"
				else:
					_state = "moving_to_end"


func _move_towards(target: Vector2, delta: float, wait_state: String, next_move_state: String) -> void:
	var to_target: Vector2 = target - global_position
	var distance_left: float = to_target.length()

	if distance_left == 0:
		# Already at target (edge case)
		_state = wait_state
		_wait_timer = wait_time
		return

	var step: float = move_speed * delta

	if step >= distance_left:
		global_position = target
		_state = wait_state
		_wait_timer = wait_time
	else:
		global_position += to_target.normalized() * step

func stop_moving() -> void:
	_active = false

func start_moving() -> void:
	if not _active:
		_active = true
