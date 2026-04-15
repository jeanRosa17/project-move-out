@tool
extends CanvasLayer
class_name HUDManager

@export var level_results: CanvasLayer
@export var dialogue: CanvasLayer 
@export var list: CanvasLayer 
@export var textbox: DialogueManager 
@onready var ap: AnimationPlayer = $"Level Results/Node2D/AnimationPlayer"

@export var packedFurniture: Array[Data.Tetronimo] = []
@export var player: Player
@export var tetris:Tetris
var tetris_camera: Camera2D 
var player_camera: Camera2D 

var levelFinished: bool = false
var allFurniture: Array
var score: int

## ensures dialogue is invisible at the start of the level
func _ready() ->void:
	#self.vis = false
	if not Engine.is_editor_hint():
		self.setAllOff()
	#self.dialogue.visible = false  
	
## Helper function that makes all other CanvasLayers of the Hud turn off when
## the root HUD node is set invisible
func setAllOff() -> void:
	for i in self.get_children():
			if (i is CanvasLayer):
				i.visible = self.visible


func get_all_furniture(startNode: Node, result: Array) -> void:
	# puts all furniture currently in the selected node into the array
	# for our level design, this should always be y_sorting
	if startNode is Furniture && startNode.visible:
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
	var current_scene = get_tree().current_scene  
	print("Current Scene: ", current_scene.name)
	
	if (current_scene.name == "HubScene"):
		return;
	if (not self.player_camera): self.player_camera = self.player.getCamera()
	if (not self.tetris_camera): self.tetris_camera = self.tetris.getCamera()
	
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

func addPackedFurniture(newFurniture:Data.Tetronimo) -> void:
	packedFurniture.append(newFurniture)
	#print("new tetro: " + packedFurniture[-1])

func checkResults() -> void:
	## Get score from Van script and display here.
	## enable tetris and have the player play that first
	
	self.player.setControls(false)

	print("Gay gay homosexual gay");
	var current_scene = get_tree().current_scene
	if (current_scene.name != "HubScene"):
		var _text:RichTextLabel = self.level_results.find_child("Score")
		_text.text = "Your score is: " + str(score)

	var _text:RichTextLabel = self.level_results.find_child("Score")
	_text.text = "Your score is: " + str(score)

	self.dialogue.visible = false
	await get_tree().create_timer(0.3).timeout
	if (current_scene.name != "HubScene"):
		ap.play("Complete")
	self.level_results.visible = true

## Ensures that the Dialogue Box turns itself off when the dialogue is finished.
func _process(_delta: float) -> void:
	if not Engine.is_editor_hint():
		if (self.textbox):
			if (self.textbox.currentTagFinished):
				self.dialogue.visible = false
			
				if (self.textbox.hasOptions):
					self.dialogue.visible = true
					if (self.textbox.get_child_count() > 0):
						$Dialogue/Textbox/Panel/YesOption.visible = self.textbox.hasOptions
						$Dialogue/Textbox/Panel/NoOption.visible = self.textbox.hasOptions
			
				
				
	## When run in the editor
	if Engine.is_editor_hint():
		self.setAllOff()


func _on_no_leave_level_button_down() -> void:
	self.visible = false
	self.textbox.currentTagFinished = true
	self.textbox.hasOptions = false
	$Dialogue/Textbox/Panel/YesOption.visible = self.textbox.hasOptions
	$Dialogue/Textbox/Panel/NoOption.visible = self.textbox.hasOptions
