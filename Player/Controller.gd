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

func handleMovement(delta:float) -> void:
	#self.movement.decelerate(delta)
	
	if (Input.is_action_pressed("MoveLeft") \
	or Input.is_action_pressed("MoveRight")
	or Input.is_action_pressed("MoveDown")
	or Input.is_action_pressed("MoveUp")):
		var direction:Vector2i = Vector2i(clampf(Input.get_axis("MoveLeft", "MoveRight"), -1, 1), \
											clampf(Input.get_axis("MoveUp", "MoveDown"), -1, 1))
		
		self.movement.accelerate(direction, delta)
		
		if (direction == Vector2i.ZERO): self.isMirrored = self.isMirrored
		self.isMirrored = direction.x < 0
	
	#if (not Input.is_action_pressed("MoveLeft") and not Input.is_action_pressed("MoveRight")): return
		#
	#if (not Input.is_action_pressed("MoveDown") and not Input.is_action_pressed("MoveUp")): return
		#
	#if (Input.is_action_pressed("MoveLeft") and Input.is_action_pressed("MoveRight")): return
		#
	#if (Input.is_action_pressed("MoveDown") and Input.is_action_pressed("MoveUp")): return
	else:
		self.movement.decelerate(delta)
