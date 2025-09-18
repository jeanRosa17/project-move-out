extends StaticBody2D

class_name Furniture

@onready var manager:StateManager = $StateManager
var currentState: State

@export var canLift:bool
@export var canPush:bool
@export var canPull:bool

@export var weight:int

func _process(delta: float) -> void:
	if (manager == null):
		Exception.new("Manager for Furniture can't be null.")
		
	self.currentState = manager.currentState
	#is_lifting(delta)
	#is_pushing(delta)
	#is_pulling(delta)
	#is_idle(delta)

func get_canLift() -> bool:
	return canLift
	
func is_lifting(delta:float) -> void:
	self.manager.currentState.transitioned.emit(self.manager.currentState, "Carried")
	
func is_pushing(delta:float) -> void:
	self.manager.currentState.transitioned.emit(self.manager.currentState, "Pushed")
	
func is_pulling(delta:float) -> void:
	self.manager.currentState.transitioned.emit(self.manager.currentState, "Pulled")
	
func is_idle(delta:float) -> void:
	self.manager.currentState.transitioned.emit(self.manager.currentState, "Idle")			
