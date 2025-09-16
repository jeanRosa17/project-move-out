class_name LiftState
extends State

@export var view:AnimatedSprite2D = null
@export var body:CharacterBody2D

## The first method called when the state is transitioned into
func enter() -> void:
	var dir:String = self.view.animation.split(" ")[1].to_lower()
	
	if not (self.view.animation.contains("lift")):
		self.view.play("lift " + dir)

## The last method called when the state is transitioned out of
func exit() -> void:
	pass

## Constantly checks for input from the user and changes state.
func update(_delta:float) -> void:
	self.body.move_and_slide()

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(_delta:float) -> void:
	pass
	
