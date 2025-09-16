class_name ThrowState
extends State

@onready var manager:StateManager = self.getManager()
@onready var backToIdle:Callable = func () -> void : self.manager.currentState.transitioned.emit(self.manager.currentState, "Idle")
@export var view:AnimatedSprite2D = null

## The first method called when the state is transitioned into
func enter() -> void:
	var dir:String = self.view.animation.split(" ")[1].to_lower()
	
	self.view.play("throw " + dir)
	#self.view.speed_scale = 2.0
	self.view.animation_finished.connect(backToIdle)

## The last method called when the state is transitioned out of
func exit() -> void:
	self.view.speed_scale = 1.0
	self.view.animation_finished.disconnect(backToIdle)

## Constantly checks for input from the user and changes state.
func update(_delta:float) -> void:
	pass

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(_delta:float) -> void:
	pass
	
