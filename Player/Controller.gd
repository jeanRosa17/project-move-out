class_name Player
extends CharacterBody2D

@onready var manager:StateManager = $StateManager
@onready var view:AnimatedSprite2D = $AnimatedSprite2D
@onready var physics:PlayerPhysics
var movement:MovementComponent

var currentState:State

func _ready() -> void:
	self.physics = preload("res://Scripts/Resources/DefaultPhysics.tres")
	self.movement = MovementComponent.new(self, self.physics)
	self.manager.start()
	
func _process(delta:float) -> void:
	if (manager == null):
		Exception.new("Manager for Controller can't be null.")
		
	self.currentState = manager.currentState
	self.handleMovement(delta)
	self.handleLift(delta)

## Handles the "Move" set of Inputs and moves the character accordingly using
## its MovementComponent.
func handleMovement(delta:float) -> void:
	if (Input.is_action_pressed("MoveLeft") \
	or Input.is_action_pressed("MoveRight")
	or Input.is_action_pressed("MoveDown")
	or Input.is_action_pressed("MoveUp")):
		var direction:Vector2i = Vector2i(clampf(Input.get_axis("MoveLeft", "MoveRight"), -1, 1), \
											clampf(Input.get_axis("MoveUp", "MoveDown"), -1, 1))
		
		self.movement.accelerate(direction, delta)
		
		if (self.manager.currentState.name != "Move"):
			self.manager.currentState.transitioned.emit(self.manager.currentState, "Move")
	
	else:
		self.movement.decelerate(delta)
		if (self.manager.currentState.name == "Move"):
			self.manager.currentState.transitioned.emit(self.manager.currentState, "Idle")

## Handles the "Lift" set of Inputs and triggers a Carryable item up
func handleLift(delta:float) -> void:
	if (Input.is_action_just_pressed("Lift")):
		if (self.manager.currentState.name != "Lift"):
			self.manager.currentState.transitioned.emit(self.manager.currentState, "Lift")
		elif (self.view.animation.contains("lift")):
			self.manager.currentState.transitioned.emit(self.manager.currentState, "Throw")
