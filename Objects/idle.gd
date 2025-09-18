extends State

@export var controller = null

## The first method called when the state is transitioned into
func enter() -> void:
	pass

## The last method called when the state is transitioned out of
func exit() -> void:
	pass
	
## Constantly checks for input from the user and changes state.
func update(_delta:float) -> void:
	pass

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(delta:float) -> void:
	pass
	#self.player.move_and_slide()
	
