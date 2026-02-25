class_name LiftState
extends State

@export var body:Player
@onready var manager:StateManager = self.getManager()
var animationFinished:bool = false

## The Player needs hasFurniture to be true and the furniture needs to be liftable.
func canEnter() -> bool:
	
	if (not self.manager.hasFurniture): 
		print("hasFunriture false")
		self.body.setControls(true)
		return false
	
	if (self.manager.furniture.canLift): return true
	
	## This elif ensures that the Input for Lifting can still go through to
	## the handlePushPull, since the controller checks lifting first and then pushing.
	elif (self.manager.furniture.canPush):
		self.manager.changeState("Push")
		return false;
	else:
		self.body.setControls(true)
		return false

## Sets the Lifting animation and sets the Furniture to enter its lift state.
func enter() -> void:
	self.animationFinished = false
	var dir:String = self.getManager().view.animation.split(" ")[1].to_lower()
	
	if not (self.getManager().wasPreviousState("Lift")):
		self.getManager().view.play("lift " + dir)
		if not (self.getManager().view.animation_finished.is_connected(exitAfterAnimationFinish)):
			self.getManager().view.animation_finished.connect(exitAfterAnimationFinish)

func update(_delta:float) -> void:
	if (self.animationFinished):
		self.manager.furniture.enterLift(self.body)
		self.manager.changeState("Idle")

func exitAfterAnimationFinish() -> void:
	self.animationFinished = true

func exit() -> void:
	if (self.getManager().view.animation_finished.is_connected(exitAfterAnimationFinish)):
		self.getManager().view.animation_finished.disconnect(exitAfterAnimationFinish)
	self.body.setControls(true)
