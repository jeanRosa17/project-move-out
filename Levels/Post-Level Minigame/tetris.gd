extends Node2D

var one_by_one_tetromino: Array = [
	#All rotations are the same
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(8, 0)}],
	
	#All rotations are the same
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(8, 0)}],
	
	#All rotations are the same
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(8, 0)}],
	
	#All rotations are the same
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(8, 0)}],
]

var two_by_two_tetromino: Array = [
	#All rotations are the same
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(5, 0)}, 
	{"pos": Vector2i(1, 0), "atlas": Vector2i(7, 0)}, 
	{"pos": Vector2i(0, 1), "atlas": Vector2i(5, 2)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(7, 2)}
	],
	
	#All rotations are the same
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(5, 0)}, 
	{"pos": Vector2i(1, 0), "atlas": Vector2i(7, 0)}, 
	{"pos": Vector2i(0, 1), "atlas": Vector2i(5, 2)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(7, 2)}
	],
	
	#All rotations are the same
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(5, 0)}, 
	{"pos": Vector2i(1, 0), "atlas": Vector2i(7, 0)}, 
	{"pos": Vector2i(0, 1), "atlas": Vector2i(5, 2)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(7, 2)}
	],
	
	#All rotations are the same
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(5, 0)}, 
	{"pos": Vector2i(1, 0), "atlas": Vector2i(7, 0)}, 
	{"pos": Vector2i(0, 1), "atlas": Vector2i(5, 2)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(7, 2)}
	],
]

var three_by_three_tetromino: Array = [
	#All rotations are the same
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(5, 0)}, 
	{"pos": Vector2i(1, 0), "atlas": Vector2i(6, 0)},
	{"pos": Vector2i(2, 0), "atlas": Vector2i(7, 0)},
	{"pos": Vector2i(0, 1), "atlas": Vector2i(5, 1)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(6, 1)},
	{"pos": Vector2i(2, 1), "atlas": Vector2i(7, 1)},
	{"pos": Vector2i(0, 2), "atlas": Vector2i(5, 2)}, 
	{"pos": Vector2i(1, 2), "atlas": Vector2i(6, 2)},
	{"pos": Vector2i(2, 2), "atlas": Vector2i(7, 2)}
	],
	
	#All rotations are the same
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(5, 0)}, 
	{"pos": Vector2i(1, 0), "atlas": Vector2i(6, 0)},
	{"pos": Vector2i(2, 0), "atlas": Vector2i(7, 0)},
	{"pos": Vector2i(0, 1), "atlas": Vector2i(5, 1)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(6, 1)},
	{"pos": Vector2i(2, 1), "atlas": Vector2i(7, 1)},
	{"pos": Vector2i(0, 2), "atlas": Vector2i(5, 2)}, 
	{"pos": Vector2i(1, 2), "atlas": Vector2i(6, 2)},
	{"pos": Vector2i(2, 2), "atlas": Vector2i(7, 2)}
	],
	
	#All rotations are the same
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(5, 0)}, 
	{"pos": Vector2i(1, 0), "atlas": Vector2i(6, 0)},
	{"pos": Vector2i(2, 0), "atlas": Vector2i(7, 0)},
	{"pos": Vector2i(0, 1), "atlas": Vector2i(5, 1)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(6, 1)},
	{"pos": Vector2i(2, 1), "atlas": Vector2i(7, 1)},
	{"pos": Vector2i(0, 2), "atlas": Vector2i(5, 2)}, 
	{"pos": Vector2i(1, 2), "atlas": Vector2i(6, 2)},
	{"pos": Vector2i(2, 2), "atlas": Vector2i(7, 2)}
	],
	
	#All rotations are the same
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(0, 1)}, 
	{"pos": Vector2i(1, 0), "atlas": Vector2i(0, 1)},
	{"pos": Vector2i(2, 0), "atlas": Vector2i(0, 1)},
	{"pos": Vector2i(0, 1), "atlas": Vector2i(0, 1)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(0, 1)},
	{"pos": Vector2i(2, 1), "atlas": Vector2i(0, 1)},
	{"pos": Vector2i(0, 2), "atlas": Vector2i(0, 1)}, 
	{"pos": Vector2i(1, 2), "atlas": Vector2i(0, 1)},
	{"pos": Vector2i(2, 2), "atlas": Vector2i(0, 1)}
	],
]

var two_by_one_tetromino: Array = [
	#0 degress
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(5, 3)}, 
	{"pos": Vector2i(1, 0), "atlas": Vector2i(7, 3)}, 
	],
	
	#90 degrees
	[{"pos": Vector2i(1, 0), "atlas": Vector2i(9, 0)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(9, 2)}, 
	],
	
	#180 degrees
	[{"pos": Vector2i(0, 1), "atlas": Vector2i(5, 3)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(7, 3)}, 
	],
	
	#270 degrees
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(9, 0)}, 
	{"pos": Vector2i(0, 1), "atlas": Vector2i(9, 2)}, 
	],
]

var three_by_one_tetromino: Array = [
	#0 degress
	[{"pos": Vector2i(0, 1), "atlas": Vector2i(5, 3)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(6, 3)}, 
	{"pos": Vector2i(2, 1), "atlas": Vector2i(7, 3)}, 
	],
	
	#90 degrees
	[{"pos": Vector2i(2, 0), "atlas": Vector2i(9, 0)}, 
	{"pos": Vector2i(2, 1), "atlas": Vector2i(9, 1)}, 
	{"pos": Vector2i(2, 2), "atlas": Vector2i(9, 2)}, 
	],
	
	#180 degrees
	[{"pos": Vector2i(0, 2), "atlas": Vector2i(5, 3)}, 
	{"pos": Vector2i(1, 2), "atlas": Vector2i(6, 3)}, 
	{"pos": Vector2i(2, 2), "atlas": Vector2i(7, 3)}, 
	],
	
	#270 degrees
	[{"pos": Vector2i(1, 0), "atlas": Vector2i(9, 0)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(9, 1)}, 
	{"pos": Vector2i(1, 2), "atlas": Vector2i(9, 2)}, 
	],
]

var four_by_two_tetromino: Array = [
	#0 degrees
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(5, 0)}, 
	{"pos": Vector2i(1, 0), "atlas": Vector2i(7, 0)}, 
	{"pos": Vector2i(0, 1), "atlas": Vector2i(5, 1)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(7, 1)},
	{"pos": Vector2i(0, 2), "atlas": Vector2i(5, 1)}, 
	{"pos": Vector2i(1, 2), "atlas": Vector2i(7, 1)},
	{"pos": Vector2i(0, 3), "atlas": Vector2i(5, 2)}, 
	{"pos": Vector2i(1, 3), "atlas": Vector2i(7, 2)}
	],
	
	#90 degrees
	[{"pos": Vector2i(0, 2), "atlas": Vector2i(5, 0)}, 
	{"pos": Vector2i(1, 2), "atlas": Vector2i(8, 1)}, 
	{"pos": Vector2i(2, 2), "atlas": Vector2i(8, 1)}, 
	{"pos": Vector2i(3, 2), "atlas": Vector2i(7, 0)},
	{"pos": Vector2i(0, 3), "atlas": Vector2i(5, 2)}, 
	{"pos": Vector2i(1, 3), "atlas": Vector2i(8, 2)}, 
	{"pos": Vector2i(2, 3), "atlas": Vector2i(8, 2)}, 
	{"pos": Vector2i(3, 3), "atlas": Vector2i(7, 2)}
	],
	
	#180 degrees
	[{"pos": Vector2i(2, 0), "atlas": Vector2i(5, 0)}, 
	{"pos": Vector2i(3, 0), "atlas": Vector2i(7, 0)}, 
	{"pos": Vector2i(2, 1), "atlas": Vector2i(5, 1)}, 
	{"pos": Vector2i(3, 1), "atlas": Vector2i(7, 1)},
	{"pos": Vector2i(2, 2), "atlas": Vector2i(5, 1)}, 
	{"pos": Vector2i(3, 2), "atlas": Vector2i(7, 1)},
	{"pos": Vector2i(2, 3), "atlas": Vector2i(5, 2)}, 
	{"pos": Vector2i(3, 3), "atlas": Vector2i(7, 2)}
	],
	
	#270 degrees
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(5, 0)}, 
	{"pos": Vector2i(1, 0), "atlas": Vector2i(8, 1)},
	{"pos": Vector2i(2, 0), "atlas": Vector2i(8, 1)}, 
	{"pos": Vector2i(3, 0), "atlas": Vector2i(7, 0)},  
	{"pos": Vector2i(0, 1), "atlas": Vector2i(5, 2)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(8, 2)},
	{"pos": Vector2i(2, 1), "atlas": Vector2i(8, 2)}, 
	{"pos": Vector2i(3, 1), "atlas": Vector2i(7, 2)}
	],
]

var four_by_three_tetromino: Array = [
	#0 degrees
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(5, 0)}, 
	{"pos": Vector2i(1, 0), "atlas": Vector2i(6, 0)}, 
	{"pos": Vector2i(2, 0), "atlas": Vector2i(7, 0)}, 
	{"pos": Vector2i(0, 1), "atlas": Vector2i(5, 1)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(6, 1)},
	{"pos": Vector2i(2, 1), "atlas": Vector2i(7, 1)}, 
	{"pos": Vector2i(0, 2), "atlas": Vector2i(5, 1)}, 
	{"pos": Vector2i(1, 2), "atlas": Vector2i(6, 1)},
	{"pos": Vector2i(2, 2), "atlas": Vector2i(7, 1)}, 
	{"pos": Vector2i(0, 3), "atlas": Vector2i(5, 2)}, 
	{"pos": Vector2i(1, 3), "atlas": Vector2i(6, 2)},
	{"pos": Vector2i(2, 3), "atlas": Vector2i(7, 2)}, 
	],
	
	#90 degrees
	[{"pos": Vector2i(0, 1), "atlas": Vector2i(5, 0)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(8, 1)}, 
	{"pos": Vector2i(2, 1), "atlas": Vector2i(8, 1)}, 
	{"pos": Vector2i(3, 1), "atlas": Vector2i(7, 0)},
	{"pos": Vector2i(0, 2), "atlas": Vector2i(5, 1)}, 
	{"pos": Vector2i(1, 2), "atlas": Vector2i(6, 1)}, #replace this tile
	{"pos": Vector2i(2, 2), "atlas": Vector2i(6, 1)}, #replace this tile
	{"pos": Vector2i(3, 2), "atlas": Vector2i(7, 1)},
	{"pos": Vector2i(0, 3), "atlas": Vector2i(5, 2)}, 
	{"pos": Vector2i(1, 3), "atlas": Vector2i(8, 2)}, 
	{"pos": Vector2i(2, 3), "atlas": Vector2i(8, 2)}, 
	{"pos": Vector2i(3, 3), "atlas": Vector2i(7, 2)}
	],
	
	#180 degrees
	[{"pos": Vector2i(1, 0), "atlas": Vector2i(5, 0)},
	{"pos": Vector2i(2, 0), "atlas": Vector2i(6, 0)}, 
	{"pos": Vector2i(3, 0), "atlas": Vector2i(7, 0)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(5, 1)},
	{"pos": Vector2i(2, 1), "atlas": Vector2i(6, 1)}, 
	{"pos": Vector2i(3, 1), "atlas": Vector2i(7, 1)},
	{"pos": Vector2i(1, 2), "atlas": Vector2i(5, 1)},
	{"pos": Vector2i(2, 2), "atlas": Vector2i(6, 1)}, 
	{"pos": Vector2i(3, 2), "atlas": Vector2i(7, 1)},
	{"pos": Vector2i(1, 3), "atlas": Vector2i(5, 2)},
	{"pos": Vector2i(2, 3), "atlas": Vector2i(6, 2)}, 
	{"pos": Vector2i(3, 3), "atlas": Vector2i(7, 2)}
	],
	
	#270 degrees
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(5, 0)}, 
	{"pos": Vector2i(1, 0), "atlas": Vector2i(8, 1)},
	{"pos": Vector2i(2, 0), "atlas": Vector2i(8, 1)}, 
	{"pos": Vector2i(3, 0), "atlas": Vector2i(7, 0)},  
	{"pos": Vector2i(0, 1), "atlas": Vector2i(5, 1)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(6, 1)}, #replace this tile
	{"pos": Vector2i(2, 1), "atlas": Vector2i(6, 1)}, #replace this tile
	{"pos": Vector2i(3, 1), "atlas": Vector2i(7, 1)},
	{"pos": Vector2i(0, 2), "atlas": Vector2i(5, 2)}, 
	{"pos": Vector2i(1, 2), "atlas": Vector2i(8, 2)},
	{"pos": Vector2i(2, 2), "atlas": Vector2i(8, 2)}, 
	{"pos": Vector2i(3, 2), "atlas": Vector2i(7, 2)}
	],
]

var tetrominoes: Array = [
	one_by_one_tetromino, 
	two_by_two_tetromino, 
	three_by_one_tetromino, 
	two_by_one_tetromino,
	three_by_one_tetromino,
	four_by_two_tetromino,
	four_by_three_tetromino
	]
	
var all_tetrominoes: Array = tetrominoes.duplicate()

const MIN_COL: int = -7
const MAX_COL: int = 6
const MIN_ROW: int = -12
const MAX_ROW: int = 11

const START_POSITION: Vector2i = Vector2i(-1, -11)
var current_position: Vector2i
var fall_timer: float = 0
var fall_interval: float = 1.0
var fast_fall_multiplier: float = 10.0

var current_tetromino_type: Array
var next_tetromino_type: Array
var rotation_index: int = 0
var active_tetromino: Array = []

var is_game_running: bool

var tile_id: int = 1
var next_piece_atlas: Vector2i

@onready var board_layer: TileMapLayer = $Board
@onready var active_layer: TileMapLayer = $Active

func _ready() -> void:
	start_new_game()
	
func start_new_game() -> void:
	is_game_running = true
	clear_tetromino()
	clear_board()
	clear_next_tetromino_preview()
	current_tetromino_type = choose_tetromino()
	next_tetromino_type = choose_tetromino()
	initialize_tetromino()
	
func _physics_process(delta: float) -> void:
	if is_game_running:
		var move_direction = Vector2i.ZERO
		
		if Input.is_action_just_pressed("MoveLeft"):
			move_direction = Vector2i.LEFT
		elif Input.is_action_just_pressed("MoveRight"):
			move_direction = Vector2i.RIGHT
		
		if move_direction != Vector2i.ZERO:
			move_tetromino(move_direction)
			
		if Input.is_action_just_pressed("MoveUp"):
			rotate_tetromino()
		
		var current_fall_interval = fall_interval
		if Input.is_action_pressed("MoveDown"):
			current_fall_interval /= fast_fall_multiplier
		
		fall_timer += delta
		if fall_timer >= current_fall_interval:
			move_tetromino(Vector2i.DOWN)
			fall_timer = 0

func choose_tetromino() -> Array:
	var selected_tetromino: Array
	if not tetrominoes.is_empty():
		tetrominoes.shuffle()
		selected_tetromino = tetrominoes.pop_front()
	else:
		tetrominoes = all_tetrominoes.duplicate()
		tetrominoes.shuffle()
		selected_tetromino = tetrominoes.pop_front()
	return selected_tetromino
	
func initialize_tetromino() -> void:
	current_position = START_POSITION
	active_tetromino = current_tetromino_type[rotation_index]
	render_tetromino(active_tetromino, current_position)
	render_tetromino(next_tetromino_type[0], Vector2i(12, -10))
	
func render_tetromino(tetromino: Array, position: Vector2i) -> void:
	for block in tetromino:
		var block_pos: Vector2i = block["pos"]
		var block_atlas: Vector2i = block["atlas"] #will need to ensure blcok atlas at location is done correctly for art
		active_layer.set_cell(position + block_pos, tile_id, block_atlas)


func clear_tetromino() -> void:
	for block in active_tetromino:
		active_layer.erase_cell(current_position + block["pos"])

func rotate_tetromino() -> void:
	if is_valid_rotation():
		clear_tetromino()
		rotation_index = (rotation_index - 1) % 4
		active_tetromino = current_tetromino_type[rotation_index]
		render_tetromino(active_tetromino, current_position)
		

func move_tetromino(direction: Vector2i) -> void:
	if is_valid_move(direction):
		clear_tetromino()
		current_position += direction
		render_tetromino(active_tetromino, current_position)
	else: 
		if direction == Vector2i.DOWN:
			land_tetromino()
			current_tetromino_type = next_tetromino_type
			next_tetromino_type = choose_tetromino()
			clear_next_tetromino_preview()
			initialize_tetromino()
			is_game_over()

func land_tetromino() -> void:
	for block in active_tetromino:
		active_layer.erase_cell(current_position + block["pos"])
		board_layer.set_cell(current_position + block["pos"], tile_id, block["atlas"])

func clear_next_tetromino_preview() -> void:
	for i in range (11, 16):
		for j in range(-10, -6):
			active_layer.erase_cell(Vector2i(i, j))

func clear_board() -> void:
	for i in range(MIN_ROW, MAX_ROW - 1):
		for j in range(MIN_COL, MAX_COL - 1):
			board_layer.erase_cell(Vector2i(j + 1, i + 1))

func is_valid_move(new_position: Vector2i) -> bool:
	for block in active_tetromino:
		if not is_within_bounds(current_position + block["pos"] + new_position):
			return false
	return true

func is_valid_rotation() -> bool:
	var next_rotation = (rotation_index + 1) % 4
	var roatted_tetromino = current_tetromino_type[next_rotation]
	
	for block in roatted_tetromino:
		if not is_within_bounds(current_position + block["pos"]):
			return false
	return true

func is_within_bounds(pos: Vector2i) -> bool:
	if pos.x <= MIN_COL or pos.x >= MAX_COL or pos.y <= MIN_ROW or pos.y >= MAX_ROW:
		return false
	
	var tile_id = board_layer.get_cell_source_id(pos)
	return tile_id == -1

func is_game_over() -> void:
	for block in active_tetromino:
		if not is_within_bounds(block["pos"] + current_position):
			land_tetromino()
			is_game_running = false
			print("You lose idiot!")
