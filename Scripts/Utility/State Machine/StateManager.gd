## Represents a State Manager. This class contains State nodes and manages the transitioning 
## between States.
class_name StateManager
extends Node

@export var initialState:State
## If true, a message will be outputed stating the state that was attempted to enter
@export var reportFails:bool = false

var currentState:State
var states:Dictionary = {}

## Adds all the child nodes that are States to this StateManager's 
## state dictionary by using the node's name (lowercased) as the keys, and
## the values as the State nodes. If this StateManager has a set initial state,
## this function starts that initial state.
func start() -> void:
	for child:State in self.get_children():
		states[child.name.to_lower()] = child
		if (not child.transitioned.is_connected(onStateChanged)): child.transitioned.connect(onStateChanged)
	
	if (self.initialState != null):
		self.initialState.enter()
		self.currentState = self.initialState

## Runs every process frame and calls the update() on the current State.
func _process(delta:float) -> void:
	if (self.currentState != null):
		self.currentState.update(delta)

## Runs every physics frame and calls the physicsUpdate() on the current State.
func _physics_process(delta:float) -> void:
	if (self.currentState != null):
		self.currentState.physicsUpdate(delta)
	
## Returns the topmost node. This node should be the parent on the local scene tree.
@warning_ignore("untyped_declaration")
func getRootNode():
	return $".."

## This function is called whenever a State signals transitioned. The function
## then confirms if it can exits the current state via canExit(). If the function successfully
## exits the state, it will confirm if it can enter the new State via canEnter(), executing enter if yes or 
## 
func onStateChanged(state:State, newStateName:String) -> void:
	if (state != self.currentState): return
	
	var newState:State = self.states.get(newStateName.to_lower())
	if (newState == null): Exception.new("The state " + newStateName + " does not exist.")
	
	if (not newState.isEnabled()): 
		push_warning("The state " + newStateName + " is currently disabled.")
		return
	
	if (self.currentState != null):
		if (self.currentState.canExit()): self.currentState.exit()
		else: return
	
	if (newState.canEnter()):
		newState.enter()
		self.currentState = newState
	else:
		if (self.reportFails): print("Failed to enter " + newStateName)
