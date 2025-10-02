class_name IdleState
extends State


@export var body:CharacterBody2D = null

## The first method called when the state is transitioned into
func enter() -> void: 
	if (self.getManager().wasPreviousState("Idle")): return
	if (self.getManager().wasPreviousState("Lift")): 
		self.getManager().view.play("idlelift " + self.getManager().view.animation.split(" ")[1].to_lower())
		return
	
	self.getManager().view.play("idle " + self.getManager().view.animation.split(" ")[1].to_lower())

## The last method called when the state is transitioned out of
func exit() -> void:
	pass
	
## Constantly checks for input from the user and changes state.
func update(_delta:float) -> void:
	pass

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(_delta:float) -> void:
	self.body.velocity = Vector2.ZERO
	#pass
	#self.body.move_and_slide()
	
