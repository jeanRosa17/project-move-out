extends CanvasLayer

class_name HUDManager

@onready var level_results: CanvasLayer = $"Level Results"
@onready var dialogue: CanvasLayer = $Dialogue
@onready var list: CanvasLayer = $ListHUD
@onready var textbox: DialogueManager = $Dialogue/Textbox
@onready var ap: AnimationPlayer = $"Level Results/Node2D/AnimationPlayer"

@onready var packedFurniture: Array[String] = []
@onready var player: Player = $"../Y-Sorting/Player"
@onready var tetris = $"../PostLevelMinigame"
@onready var tetris_camera: Camera2D = $"../PostLevelMinigame/TetrisCamera"
@onready var player_camera: Camera2D = $"../Y-Sorting/Player/PlayerCamera"

var levelFinished: bool = false
var allFurniture: Array
var score: int

## ensures dialogue is invisible at the start of the level
func _ready() ->void:
	self.dialogue.visible = false

func get_all_furniture(startNode: Node, result: Array) -> void:
	# puts all furniture currently in the selected node into the array
	# for our level design, this should always be y_sorting
	if startNode is Furniture:
		if (startNode.canLift || (startNode.canPush && startNode.canPull)):
			result.push_back(startNode)
	for child in startNode.get_children():
		get_all_furniture(child, result)
func get_max_score() -> float:
	# calculates the maximum score available in the level
	# NOT FULLY IMPLEMENTED
	get_all_furniture($"../Y-Sorting", allFurniture)
	return 1
##runs tetris if the level is not over
func runTetris() -> void:
	if (!levelFinished && !packedFurniture.is_empty()):
		# switch controls
		player.setControls(false)
		player.manager.changeState("Idle")
		print(player.canControl)
		# set camera to tetris
		tetris_camera.enabled = true
		tetris_camera.make_current()
		# run tetris, setting the current score to:
		# tetris's output/total possible score
		if (!tetris.game_over):
			tetris.intialize_game(packedFurniture)
func stopTetris(score: int) -> void:
	packedFurniture.clear()
	# check if the furniture list is empty
	# check if tetris has game over
	# if either, level is over (but end screen not triggered)
	var currentFurniture: Array
	get_all_furniture($"../Y-Sorting", currentFurniture)
	if (currentFurniture.size() == 0 || tetris.game_over):
		levelFinished = true
	# swap the cameras and controlls back
	player_camera.make_current()
	tetris_camera.enabled = false
	player.setControls(true)

## Makes the Dialogue layer visible and calls setDialogueTo on the textbox node
func setDialogueTo(dTag:DialogueTag) -> void:
	self.dialogue.visible = true
	print(self.dialogue.visible)
	self.textbox.setDialogueTo(dTag)

func addPackedFurniture(newFurniture:String) -> void:
	packedFurniture.append(newFurniture)
	print("new tetro: " + packedFurniture[-1])

func checkResults() -> void:
	## Get score from Van script and display here.
	## enable tetris and have the player play that first
	
	print("Gay gay homosexual gay");
	var _text:RichTextLabel = self.level_results.find_child("Score")
	self.dialogue.visible = false
	await get_tree().create_timer(0.3).timeout
	ap.play("Complete")
	self.level_results.visible = true

## Ensures that the Dialogue Box turns itself off when the dialogue is finished.
func _process(_delta: float) -> void:
	#player_camera.make_current()
	if (self.textbox.currentTagFinished):
		self.dialogue.visible = false
	#
	#if (not self.visible):
		#for i in self.get_children():
			#if (i is CanvasLayer):
				#i.visible = self.visible
