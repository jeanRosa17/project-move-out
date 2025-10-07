extends Area2D

class_name FurniturePush

@export var canLift:bool
@export var canPush:bool
@export var canPull:bool
@export var weight:int
var isLifting: bool = false

@export var liftPosition:Vector2

#func _process(_delta: float) -> void:
	#self.move_and_collide(self.velocity * _delta)

func get_canLift() -> bool:
	return canLift

## Reparents this Furniture to the given CharacterBody
func enterLift(body:CharacterBody2D) -> void:
	self.collision_layer = 1;
	self.collision_mask = 6;
	self.position = body.position + self.liftPosition
	self.reparent(body)
	self.isLifting = true

## Returns this Furniture back to not being held
func exitLift() -> void:
	var body:Area2D = self.get_parent()
	body.remove_child(self)
	body.add_sibling(self)
	self.position = body.position + self.liftPosition
	self.collision_layer = 2;
	self.collision_mask = 7;
	self.isLifting = false
	
func _on_player_detection_body_entered(body: Node2D) -> void:
	if body.is_in_group("Immovable Object"):
		##add code so player is not able to move and object cannot leave
		pass
	pass # Replace with function body.
