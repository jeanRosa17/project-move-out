class_name LiftState
extends State

@export var body:Player
@onready var manager:StateManager = self.getManager()

## Furniture needs to be not null and needs to be lifted.
func canEnter() -> bool:
	if (self.manager.furniture == null):
		return false
	
	if (self.manager.furniture.canLift): return true
	
	elif (self.manager.furniture.canPush):
		self.manager.changeState("Push")
		return false;
	else:
		return false

## The first methosd called when the state is transitioned into
func enter() -> void:
	var dir:String = self.getManager().view.animation.split(" ")[1].to_lower()
	
	if not (self.getManager().wasPreviousState("Lift")):
		self.getManager().view.play("lift " + dir)
		
	self.manager.furniture.enterLift(self.body)

## The last method called when the state is transitioned out of
func exit() -> void:
	pass

## Constantly checks for input from the user and changes state.
func update(_delta:float) -> void:
	self.body.move_and_slide()

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(_delta:float) -> void:
	pass
