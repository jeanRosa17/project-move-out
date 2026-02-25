extends CanvasLayer

class_name HUDManager

@onready var level_results: CanvasLayer = $"Level Results"
@onready var dialogue: CanvasLayer = $Dialogue
@onready var textbox: DialogueManager = $Dialogue/Textbox
@onready var packedFurniture: Array[String] = []

## ensures dialogue is invisible at the start of the level
func _ready() ->void:
	self.dialogue.visible = false

## Makes the Dialogue layer visible and calls setDialogueTo on the textbox node
func setDialogueTo(dTag:DialogueTag) -> void:
	self.dialogue.visible = true
	self.textbox.setDialogueTo(dTag)

func addPackedFurniture(newFurniture:String) -> void:
	packedFurniture.append(newFurniture)
	print("new tetro: " + packedFurniture[-1])

func checkResults() -> void:
	## Get score from Van script and display here.
	## enable tetris and have the player play that first
	
	print("Gay gay homosexual gay");
	var _text:RichTextLabel = self.level_results.find_child("Score")
	self.level_results.visible = true

## Ensures that the Dialogue Box turns itself off when the dialogue is finished.
func _process(_delta: float) -> void:
	if (self.textbox.currentTagFinished):
		self.dialogue.visible = false
	#
	#if (not self.visible):
		#for i in self.get_children():
			#if (i is CanvasLayer):
				#i.visible = self.visible
