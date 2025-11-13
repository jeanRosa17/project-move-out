extends CanvasLayer

class_name HUDManager

@onready var level_results: CanvasLayer = $"Level Results"
@onready var dialogue: CanvasLayer = $Dialogue
@onready var textbox: DialogueManager = $Dialogue/Textbox


## Makes the Dialogue layer visible and calls setDialogueTo on the textbox node
func setDialogueTo(dTag:DialogueTag) -> void:
	self.dialogue.visible = true
	self.textbox.setDialogueTo(dTag)

func checkResults(score) -> void:
	## Get score from Van script and display here.
	var text:RichTextLabel = self.level_results.find_child("Score")
	text.text = str("Your score is: ", score)
	self.level_results.visible = true

func _process(delta: float) -> void:
	if (self.textbox.currentTagFinished):
		self.dialogue.visible = false
	
	if (not self.visible):
		for i in self.get_children():
			if (i is CanvasLayer):
				i.visible = self.visible
