class_name ThrowState
extends State

@onready var manager:StateManager = self.getManager()
@onready var backToIdle:Callable = func () -> void : self.manager.changeState("Idle")
@export var throwDistance:int = 12
@export var area2D:Area2D
var hadEmptySpace:bool


func canEnter() -> bool:
	return self.manager.getStateName() == "Idle" && self.hadEmptySpace

## The first method called when the state is transitioned into
func enter() -> void:
	var dir:String = self.getManager().view.animation.split(" ")[1].to_lower()
	
	
	self.getManager().view.play("throw " + dir)
	self.getManager().view.animation_finished.connect(backToIdle)

## The last method called when the state is transitioned out of
func exit() -> void:
	if (self.manager.furniture):
		self.manager.furniture.exitLift()
		
		var dir:String = self.getManager().view.animation.split(" ")[1].to_lower()


	if (self.getManager().view.animation_finished.is_connected(backToIdle)):
		self.getManager().view.animation_finished.disconnect(backToIdle)

## Constantly checks for input from the user and changes state.
func update(_delta:float) -> void:
	pass

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(_delta:float) -> void:
	pass

func _on_detected_body_entered(_body: Node2D) -> void:
	self.hadEmptySpace = false

func _on_detected_body_exited(_body: Node2D) -> void:
	self.hadEmptySpace = true
