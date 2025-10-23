extends State

@export var controller = null

## Determines if the state can be entered. By default returns true.
func canEnter() -> bool:
	return true

## The first method called when the state is transitioned into
func enter() -> void:
	pass

## Determines if the state can be exited. By default returns true.
func canExit() -> bool:
	return true

## The last method called when the state is transitioned out of
func exit() -> void:
	pass
	
## Constantly checks for input from the user and changes state.
func update(_delta:float) -> void:
	pass

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(delta:float) -> void:
	pass

## Disables this State. Unlike canEnter, this function's job is to be a sure fire way to prevent a
## State from being accessed at all.
func disable() -> void:
	self._isEnabled = false
	self.onDisabled.emit()

## Reenables this State
func enable() -> void:
	self._isEnabled = true
	self.onEnabled.emit()

## Returns whether this State is enabled
func isEnabled() -> bool:
	return self._isEnabled

## Returns the State's name in addition to the time that the function was called.
func logStatus() -> String:
	return str(self.name + " @" + Time.get_time_string_from_system() + "|")
	
## Returns the StateManager that this State should belong to.
func getManager() -> StateManager:
	if (not self.get_parent() is StateManager):
		Exception.new("The parent of a State should be a StateManager.")
	
	return self.get_parent()

