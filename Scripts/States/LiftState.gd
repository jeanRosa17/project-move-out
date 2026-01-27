class_name LiftState
extends State

@export var body:Player
@onready var manager:StateManager = self.getManager()

## The Player needs hasFurniture to be true and the furniture needs to be liftable.
func canEnter() -> bool:
	if (not self.manager.hasFurniture): return false
	
	if (self.manager.furniture.canLift): return true
	
	## This elif ensures that the Input for Lifting can still go through to
	## the handlePushPull, since the controller checks lifting first and then pushing.
	elif (self.manager.furniture.canPush):
		self.manager.changeState("Push")
		return false;
	else:
		return false

## Sets the Lifting animation and sets the Furniture to enter its lift state.
func enter() -> void:
	var dir:String = self.getManager().view.animation.split(" ")[1].to_lower()
	
	if not (self.getManager().wasPreviousState("Lift")):
		self.getManager().view.play("lift " + dir)
		
	self.manager.furniture.enterLift(self.body)

func exit() -> void:
	pass

## Constantly checks for input from the user and changes state.
func update(_delta:float) -> void:
	self.body.move_and_slide()
