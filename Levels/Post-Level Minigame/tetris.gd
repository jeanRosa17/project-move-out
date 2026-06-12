class_name Tetris

extends Node2D
#region Tetronimo arrays

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

var three_by_two_tetromino: Array = [
	#0 degrees
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(5, 0)}, 
	{"pos": Vector2i(1, 0), "atlas": Vector2i(7, 0)}, 
	{"pos": Vector2i(0, 1), "atlas": Vector2i(5, 1)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(7, 1)},
	{"pos": Vector2i(0, 2), "atlas": Vector2i(5, 2)}, 
	{"pos": Vector2i(1, 2), "atlas": Vector2i(7, 2)}
	],
	
	#90 degrees
	[{"pos": Vector2i(0, 0), "atlas": Vector2i(5, 0)}, 
	{"pos": Vector2i(1, 0), "atlas": Vector2i(8, 1)},
	{"pos": Vector2i(2, 0), "atlas": Vector2i(7, 0)}, 
	{"pos": Vector2i(0, 1), "atlas": Vector2i(5, 2)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(8, 2)},
	{"pos": Vector2i(2, 1), "atlas": Vector2i(7, 2)}, 
	],
	
	#180 degrees
	[{"pos": Vector2i(1, 0), "atlas": Vector2i(5, 0)}, 
	{"pos": Vector2i(2, 0), "atlas": Vector2i(7, 0)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(5, 1)}, 
	{"pos": Vector2i(2, 1), "atlas": Vector2i(7, 1)},
	{"pos": Vector2i(1, 2), "atlas": Vector2i(5, 2)}, 
	{"pos": Vector2i(2, 2), "atlas": Vector2i(7, 2)}
	],
	
	#270 degrees
	[{"pos": Vector2i(0, 1), "atlas": Vector2i(5, 0)}, 
	{"pos": Vector2i(1, 1), "atlas": Vector2i(8, 1)}, 
	{"pos": Vector2i(2, 1), "atlas": Vector2i(7, 0)}, 
	{"pos": Vector2i(0, 2), "atlas": Vector2i(5, 2)}, 
	{"pos": Vector2i(1, 2), "atlas": Vector2i(8, 2)}, 
	{"pos": Vector2i(2, 2), "atlas": Vector2i(7, 2)}, 
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
#endregion

var tetrominoes: Array = []

var score: int = 0

# editable values for when tetris board wants to be re-drawn/reconfigured in future level
@export var MIN_COL: int = -7    #left value of tetris board
@export var MAX_COL: int = 6     #right value of tetris board
@export var MIN_ROW: int = -12   #top value of tetris board
@export var MAX_ROW: int = 11    #bottom value of tetris board

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
var is_game_stopped: bool = true
var game_over: bool

var initial_empty_cells: int = 0

var tile_id: int = 0
var next_piece_atlas: Vector2i

@onready var board_layer: TileMapLayer = $Board
@onready var active_layer: TileMapLayer = $Active
@onready var preview_layer: TileMapLayer = $Preview
@onready var hud:HUDManager = %HUD
@onready var score_text: RichTextLabel = $ScoreValue

var audio_player:TetrisAudio

func _ready() -> void:
	start_new_game()
	audio_player = self.find_child("Tetris Audio")
	
func start_new_game() -> void:
	clear_tetromino()
	clear_board()
	clear_next_tetromino_preview()
	get_total_cells()

func intialize_game(furniture_list: Array) -> void:
	for furniture in furniture_list:
		add_tetrominos(furniture)
	
	is_game_running = true
	is_game_stopped = false
	current_tetromino_type = choose_tetromino()
	next_tetromino_type = choose_tetromino()
	initialize_tetromino()
	
func pause_game()-> void:
	is_game_running = false
	is_game_stopped = true
	
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
		
		clear_tetromino()
		render_tetromino(active_tetromino, current_position)

	else:
		#show end screen here
		if (!is_game_stopped):
			pause_game()
			hud.stopTetris(score)
		pass

func getCamera() -> Camera2D:
	return $TetrisCamera

func add_tetrominos(tetromino: Data.Tetronimo) -> void:
	if (tetromino == Data.Tetronimo.one_by_one):
		tetrominoes.append(one_by_one_tetromino)
	elif (tetromino == Data.Tetronimo.two_by_two):
		tetrominoes.append(two_by_two_tetromino)
	elif (tetromino == Data.Tetronimo.two_by_one):
		tetrominoes.append(two_by_one_tetromino)
	elif (tetromino == Data.Tetronimo.three_by_one):
		tetrominoes.append(three_by_one_tetromino)
	elif (tetromino == Data.Tetronimo.three_by_two):
		tetrominoes.append(three_by_two_tetromino)
	elif (tetromino == Data.Tetronimo.three_by_three):
		tetrominoes.append(three_by_three_tetromino)
	elif (tetromino == Data.Tetronimo.four_by_two):
		tetrominoes.append(four_by_two_tetromino)
	elif (tetromino == Data.Tetronimo.four_by_three):
		tetrominoes.append(four_by_three_tetromino)
	else:
		print("Incorrect tetronimo assignment")

func choose_tetromino() -> Array:
	var selected_tetromino: Array
	if not tetrominoes.is_empty():
		tetrominoes.shuffle()
		selected_tetromino = tetrominoes.pop_front()
	return selected_tetromino
	
func initialize_tetromino() -> void:
	current_position = START_POSITION
	if (!next_tetromino_type.is_empty()):
		render_preview(next_tetromino_type[0])
	else:
		preview_layer.clear()
	if (!current_tetromino_type.is_empty()):
		active_tetromino = current_tetromino_type[rotation_index]
		render_tetromino(active_tetromino, current_position)

func render_tetromino(tetromino: Array, position: Vector2i) -> void:
	for block in tetromino:
		var world_pos = position + block["pos"]
		var block_atlas: Vector2i = block["atlas"] #will need to ensure blcok atlas at location is done correctly for art
		active_layer.set_cell(world_pos, tile_id, block_atlas)

func render_preview(tetromino: Array) -> void:
	preview_layer.clear()
	for block in tetromino:
		var pos = Vector2i(12, -10) + block["pos"]
		preview_layer.set_cell(pos, tile_id, block["atlas"])

func clear_tetromino() -> void:
	for pos in active_layer.get_used_cells():
		active_layer.erase_cell(pos)

func rotate_tetromino() -> void:
	if is_valid_rotation():
		clear_tetromino()
		rotation_index = (rotation_index + 1) % 4
		active_tetromino = current_tetromino_type[rotation_index]
		render_tetromino(active_tetromino, current_position)
		audio_player.rotateSound()
		

func move_tetromino(direction: Vector2i) -> void:
	clear_tetromino()
	
	if is_valid_move(direction):
		current_position += direction		
	else: 
		if direction == Vector2i.DOWN:
			land_tetromino()
			#update score value
			score_text.text = str(score)
			current_tetromino_type = next_tetromino_type
			next_tetromino_type = choose_tetromino()
			clear_next_tetromino_preview()
			initialize_tetromino()
			is_game_over()
	
	audio_player.tick()

func land_tetromino() -> void:
	for block in active_tetromino:
		active_layer.erase_cell(current_position + block["pos"])
		board_layer.set_cell(current_position + block["pos"], tile_id, block["atlas"])
		active_tetromino = []
		score += 1
		
		audio_player.landing()

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
	if pos.x < MIN_COL or pos.x > MAX_COL or pos.y < MIN_ROW or pos.y > MAX_ROW:
		return false
	
	var tile_id = board_layer.get_cell_source_id(pos)
	return tile_id == -1

func is_within_border(pos: Vector2i) -> bool:
	return pos.x > MIN_COL and pos.x < MAX_COL and pos.y > MIN_ROW and pos.y < MAX_ROW

func is_game_over() -> void:
	if (active_tetromino.is_empty() && next_tetromino_type.is_empty()):
		#check to see if we finish putting all furniture in level
		if (hud.levelFinished):
			print("You win!")
			var multiplier = score_multiplier()
			score = int(score * multiplier)
		
		is_game_running = false
	else:
		for block in active_tetromino:
			if not is_within_bounds(block["pos"] + current_position):
				land_tetromino()
				#update score value
				score_text.text = str(score)
				is_game_running = false
				print("You lose idiot!")
				game_over = true

func get_total_cells() -> void:
	initial_empty_cells = 0
	
	for y in range(MIN_ROW, MAX_ROW):
		for x in range (MIN_COL, MAX_COL):
			var pos = Vector2i(x, y)
			
			#valid tetronimo place space (for not perfect boards)
			if board_layer.get_cell_source_id(pos) == -1:
				initial_empty_cells += 1

func count_remaining_cells() -> int:
	var visited := {}
	
	var queue := []
	
	queue.append(START_POSITION)
	visited[START_POSITION]
	visited[START_POSITION] = true
	
	var count := 0
	
	while queue.size() > 0:
		var current = queue.pop_front()
		
		if not is_within_border(current):
			continue
		
		if board_layer.get_cell_source_id(current) != -1:
			continue
		
		count += 1
		
		for dir in [Vector2i.LEFT, Vector2i.RIGHT, Vector2i.UP, Vector2i.DOWN]:
			var next = current + dir
			if not visited.has(next):
				visited[next] = true
				queue.append(next)
	
	return count

func packing_efficiency() -> float:
	var remaining = count_remaining_cells()
	var filled = initial_empty_cells - remaining
	
	if (initial_empty_cells == 0):
		return 1.0
	
	return float(filled) / float(initial_empty_cells)

func score_multiplier() -> float:
	var efficiency = packing_efficiency()
	return 1.0 + efficiency * 2.0
