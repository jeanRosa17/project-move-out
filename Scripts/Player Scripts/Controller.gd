class_name Player
extends CharacterBody2D

@onready var manager:StateManager = $StateManager
@onready var view:AnimatedSprite2D = $NewAnimatedSprite2D

@export var canControl:bool = true
var locked_axis := "none"

func _ready() -> void:
	self.manager.start()
	
	
func _process(delta:float) -> void:
	if (manager == null):
		Exception.new("Manager for Controller can't be null.")
	
	if (canControl):
		self.handleMovement(delta)
		self.handleLift(delta)
		#self.handlePushPull(delta)
		self.handleInteract(delta)
		self.handleRotate(delta)
	
	#animations()
	#lockDirection()

func lockDirection() -> void:
	locked_axis = "none"
	var x := int(Input.is_action_pressed("MoveRight")) \
		- int(Input.is_action_pressed("MoveLeft"))
	var y := int(Input.is_action_pressed("MoveDown")) \
		- int(Input.is_action_pressed("MoveUp"))
		
	if locked_axis == "horizontal" and x == 0:
		locked_axis = "none"
	elif locked_axis == "vertical" and y == 0:
		locked_axis = "none"
		
	if locked_axis == "none":
		if y != 0:
			locked_axis = "vertical"
		elif x != 0:
			locked_axis = "horizontal"
		
	self.manager.direction = Vector2i.ZERO
	
	if locked_axis == "horizontal":
		self.manager.direction.y = 0
		self.manager.direction.x = x
	elif locked_axis == "vertical":
		self.manager.direction.x = 0
		self.manager.direction.y = y
		

func animations() -> void:
	var prefix:String = "move"

	if (self.manager.hasFurniture):
		if (self.manager.furniture.isPushed):
			prefix = "pushing"
		if (self.manager.furniture.isLifted):
			prefix = "movelift"
	
	if Input.is_action_pressed("MoveLeft") and locked_axis != "vertical":
		self.view.flip_h = true
		self.manager.view.play(prefix + " side")
	
	elif Input.is_action_pressed("MoveRight") and locked_axis != "vertical":
		self.view.flip_h = false
		self.manager.view.play(prefix + " side")
		return

	elif Input.is_action_pressed("MoveUp") and locked_axis != "horizontal":
		self.manager.view.play(prefix + " up")
		return
		
	elif Input.is_action_pressed("MoveDown") and locked_axis != "horizontal":
		self.manager.view.play(prefix + " down")
		return

## Handles the "Move" set of Inputs and transfers the state to the "Move" state. Otherwise
## if the player is not inputting anything, the state defaults to "Idle".
@warning_ignore("narrowing_conversion")
func handleMovement(_delta:float) -> void:
	if (Input.is_action_pressed("MoveLeft")
	or Input.is_action_pressed("MoveRight")
	or Input.is_action_pressed("MoveDown")
	or Input.is_action_pressed("MoveUp")):
		self.manager.direction = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown", 0.1)                  
		lockDirection()
		if (self.manager.getStateName() != "Move" && self.manager.getStateName() != "Lift"):
			self.manager.changeState("Move")
			
		#if (self.manager.getStateName() == "Lift"):
			#self.manager.changeState("Move")
			
		#if (self.manager.getStateName() == "Push"):
			#self.manager.changeState("Move")
	
	else:
		if (self.manager.getStateName() == "Move"):
			self.manager.changeState("Idle")


## Handles the "Lift" set of Inputs and enters the Lift State if
## 1. Lift is inputed 
## 2. node from the Furniture Group is around the player
## 3. Furniture node can be lifted 
func handleLift(_delta:float) -> void:
	if (Input.is_action_just_pressed("Lift")):
		
		if (self.manager.getStateName() != "Move"):
			if ((self.manager.hasFurniture) and (self.manager.furniture.isLifted)):
				self.setControls(false)
				self.manager.changeState("Throw")
				
			elif (self.manager.getStateName() != "Lift"): 
				self.setControls(false)
				self.manager.changeState("Lift")


## Handles "Push" and "Pull"
func handlePushPull(_delta:float) -> void:
	if (Input.is_action_just_pressed("Push-Pull")):
		if (self.manager.getStateName() != "Push"): self.manager.changeState("Push")

## Handles the "Interact" input. For now, this triggers dialogue.
func handleInteract(_delta:float) -> void:
	if (Input.is_action_just_pressed("Interact")):
		if ((self.manager.getStateName() == "Idle") and (not self.manager.wasPreviousState("Lift"))):
			self.manager.changeState("Interact")
				

func handleRotate(_delta:float) -> void:
	if (Input.is_action_just_pressed("Rotate")):
		self.manager.furniture.rotateObj()

## Sets the controller to either accept or ignore input.
func setControls(flag:bool) -> void:
	self.set_process_input(flag)
	self.canControl = flag
