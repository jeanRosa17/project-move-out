extends CharacterBody2D

class_name Furniture

@export var canLift:bool
@export var canPush:bool
@export var canPull:bool
@export var weight:int


func _process(_delta: float) -> void:
	self.move_and_slide()

func get_canLift() -> bool:
	return canLift


func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Immovable Object"):
		##add code so player is not able to move and object cannot leave
		pass
	pass # Replace with function body.
