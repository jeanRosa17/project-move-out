## An abstract class that represents a set of behaviors and input handling for a root object.
## States are contained and transitioned in / out by a StateManager.
## Classes that extend State must override all of the void methods.
class_name State
extends Node

var _isEnabled:bool = true

## This signal calls up to the StateManager to inform it when it wants the state
## to change.
signal transitioned

## This signal tells those subscribed when this state has successfully been entered
signal entered(state:State)

signal onDisabled
signal onEnabled

## The first method called when the state is transitioned into
func enter() -> void:
	Exception.new("All State methods should be overridden.")
	
## Determines if the state can be entered. By default returns true.
func canEnter() -> bool:
	return true

## The last method called when the state is transitioned out of
func exit() -> void:
	Exception.new("All State methods should be overridden.")

## Determines if the state can be exited. By default returns true.
func canExit() -> bool:
	return true

## This method runs every _process() frame of the StateManager.
func update(_delta:float) -> void:
	pass
	#Exception.new("All State methods should be overridden.")
	
## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(_delta:float) -> void:
	pass
	#Exception.new("All State methods should be overridden.")

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

func logStatus() -> String:
	return str(self.name + " @" + Time.get_time_string_from_system() + "|")
