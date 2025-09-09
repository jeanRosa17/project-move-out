class_name Player
extends CharacterBody2D

@onready var model:StateManager = $StateManager
@onready var view:AnimatedSprite2D = $AnimatedSprite2D
@onready var physics:PlayerPhysics
var movement:MovementComponent

var currentState:State
var isMirrored:bool = false

func _ready() -> void:
	self.physics = preload("res://Scripts/Resources/DefaultPhysics.tres")
	self.movement = MovementComponent.new(self, self.physics)
	self.model.start()
	
func _process(delta:float) -> void:
	if (model == null):
		Exception.new("Model for Controller can't be null.")
		
	self.currentState = model.currentState
	self.handleMovement(delta)

## Looks out for the "Move" set of Inputs and moves the character accordingly using
## its MovementComponent.
func handleMovement(delta:float) -> void:
	if (Input.is_action_pressed("MoveLeft") \
	or Input.is_action_pressed("MoveRight")
	or Input.is_action_pressed("MoveDown")
	or Input.is_action_pressed("MoveUp")):
		var direction:Vector2i = Vector2i(clampf(Input.get_axis("MoveLeft", "MoveRight"), -1, 1), \
											clampf(Input.get_axis("MoveUp", "MoveDown"), -1, 1))
		
		self.movement.accelerate(direction, delta)
		
		if (direction == Vector2i.ZERO): self.isMirrored = self.isMirrored
		self.isMirrored = direction.x < 0
		
		if (self.model.currentState.name != "Move"):
			self.model.currentState.transitioned.emit(self.model.currentState, "Move")
	
	else:
		self.movement.decelerate(delta)
		if (self.model.currentState.name != "Idle"):
			self.model.currentState.transitioned.emit(self.model.currentState, "Idle")
