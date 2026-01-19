extends State

@onready var hud: HUDManager = self.get_parent().get_parent().get_node("%HUD")
@onready var textbox: DialogueManager

## The first method called when the state is transitioned into
func enter() -> void:
	if ((not self.getManager().hasFurniture) or self.getManager().furniture.dialogueTag == null):
		self.hud.setDialogueTo(load("res://Scripts/Dialogue/nullDialogue.tres"))
	else:
		self.hud.setDialogueTo(self.getManager().furniture.dialogueTag)

func exit() -> void:
	pass
