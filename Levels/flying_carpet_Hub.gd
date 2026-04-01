extends Sprite2D
@onready var leave_area: Area2D = $"Leave Area"
@onready var collision_shape_2d: CollisionShape2D = $"Leave Area/CollisionShape2D"

func _on_end_level() -> void:
	%HUD.setDialogueTo(DialogueTag.new().create("res://Narrative/GenericDialogue.txt", "endLevel"))
	%HUD.checkResults()


## Triggered when the player leaves the Carpet's area2D
func _trigger_tetris(body: Node2D) -> void:
	%HUD.runTetris()
