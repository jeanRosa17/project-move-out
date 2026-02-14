class_name ThrowState
extends State

@onready var manager:StateManager = self.getManager()
@onready var backToIdle:Callable = func () -> void : self.manager.changeState("Idle")
@export var area2D:Area2D
var canDrop:bool

## Furniture can be dropped if the player is standing still and there's a spot to place
## the furniture (furniture.canBeDropped must be true)
func canEnter() -> bool:
	return self.manager.getStateName() == "Idle" && self.manager.furniture.canBeDropped

## The first method called when the state is transitioned into
func enter() -> void:
	var dir:String = self.getManager().view.animation.split(" ")[1].to_lower()
	
	
	self.getManager().view.play("throw " + dir)
	self.getManager().view.animation_finished.connect(backToIdle)

## Forces the furniture into its exitLift state, alongisde disconnecting the
## backToIdle method to ensure no errors occurs.
func exit() -> void:
	if (self.manager.hasFurniture):
		self.manager.furniture.exitLift()

	if (self.getManager().view.animation_finished.is_connected(backToIdle)):
		self.getManager().view.animation_finished.disconnect(backToIdle)

## If the Detector is overlapping with something, then the Furniture can't be
## dropped.
func _on_detected_body_entered(_body: Node2D) -> void:
	if(self.manager.hasFurniture):
		self.manager.furniture.canBeDropped = false

## By default, a Furniture can be dropped, but this signal ensures it returns
## back to true if the player overlaps with a wall or another furniture
func _on_detected_body_exited(_body: Node2D) -> void:
	if (self.manager.hasFurniture):
		self.manager.furniture.canBeDropped = true
