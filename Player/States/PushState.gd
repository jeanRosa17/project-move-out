class_name PushState

extends State

@onready var manager:StateManager = self.getManager()
@onready var backToIdle:Callable = func () -> void : self.manager.currentState.transitioned.emit(self.manager.currentState, "Push")

func enter() -> void: 
	pass

## The last method called when the state is transitioned out of
func exit() -> void:
	pass
	
## Constantly checks for input from the user and changes state.
func update(_delta:float) -> void:
	pass

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(_delta:float) -> void:
	pass
	#pass
	#self.body.move_and_slide()
	
