class_name Player
extends CharacterBody2D

@onready var manager:StateManager = $StateManager
@onready var view:AnimatedSprite2D = $NewAnimatedSprite2D


func _ready() -> void:
	self.manager.start()
	
	
func _process(delta:float) -> void:
	if (manager == null):
		Exception.new("Manager for Controller can't be null.")
	
	self.handleMovement(delta)
	self.handleLift(delta)
	self.handlePushPull(delta)

## Handles the "Move" set of Inputs and moves the character accordingly using
## its MovementComponent.
@warning_ignore("narrowing_conversion")
func handleMovement(_delta:float) -> void:
	if (Input.is_action_pressed("MoveLeft") \
	or Input.is_action_pressed("MoveRight")
	or Input.is_action_pressed("MoveDown")
	or Input.is_action_pressed("MoveUp")):
		self.manager.direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown", 0.1)                  
		#print(self.manager.direction)
			
		if (self.manager.getStateName() != "Move" && self.manager.getStateName() != "Lift"):
			self.manager.changeState("Move")
			
		if (self.manager.getStateName() == "Lift"):
			self.manager.changeState("Move")
			
		if (self.manager.getStateName() == "Push"):
			self.manager.changeState("Move")
	
	else:
		if (self.manager.getStateName() == "Move" && self.manager.getStateName() != "Lift"):
			self.manager.changeState("Idle")


## Handles the "Lift" set of Inputs and enters the Lift State if
## 1. Lift is inputed 
## 2. node from the Furniture Group is around the player
## 3. Furniture node can be lifted 
func handleLift(_delta:float) -> void:
	if (Input.is_action_just_pressed("Lift")):
		if ((self.manager.furniture) and (self.manager.furniture.isLifting)): 
			self.manager.changeState("Throw")
			
		elif (self.manager.getStateName() != "Lift"): self.manager.changeState("Lift")

## Handles "Push" and "Pull"
func handlePushPull(_delta:float) -> void:
	if (Input.is_action_pressed("Push-Pull")):
		#issue with entering following state
		if (self.manager.getStateName() != "Push"): self.manager.changeState("Push")
