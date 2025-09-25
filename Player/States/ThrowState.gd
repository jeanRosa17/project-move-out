class_name ThrowState
extends State

@onready var manager:StateManager = self.getManager()
@onready var backToIdle:Callable = func () -> void : self.manager.currentState.transitioned.emit(self.manager.currentState, "Idle")
@export var view:AnimatedSprite2D = null
@export var throwDistance:int = 20
@export var area2D:Area2D


func canEnter() -> bool:
	self.area2D.collision_mask = 6
	var emptyDropZone:bool = not self.area2D.has_overlapping_bodies()
	self.area2D.collision_mask = 1
	return self.manager.getStateName() == "Idle" && emptyDropZone

## The first method called when the state is transitioned into
func enter() -> void:
	var dir:String = self.view.animation.split(" ")[1].to_lower()
	
	self.view.play("throw " + dir)
	self.view.animation_finished.connect(backToIdle)

## The last method called when the state is transitioned out of
func exit() -> void:
	if (self.manager.furniture):
		self.manager.furniture.exitLift()
		
		var dir:String = self.view.animation.split(" ")[1].to_lower()

		match (dir):
			"side":
				if (self.view.flip_h):
					self.manager.furniture.position.x -= self.throwDistance
				else:
					self.manager.furniture.position.x += self.throwDistance
			"up":
				self.manager.furniture.position.y -= self.throwDistance
			"down":
				self.manager.furniture.position.y += self.throwDistance
				
	if (self.view.animation_finished.is_connected(backToIdle)):
		self.view.animation_finished.disconnect(backToIdle)

## Constantly checks for input from the user and changes state.
func update(_delta:float) -> void:
	pass

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(_delta:float) -> void:
	pass
