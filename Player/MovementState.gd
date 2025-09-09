class_name MovementState
extends State

@export var view:AnimatedSprite2D = null
@export var body:CharacterBody2D

## The first method called when the state is transitioned into
func enter() -> void:
	if ((is_equal_approx(self.body.velocity.y, 0.0))
		and (not (is_equal_approx(self.body.velocity.x, 0.0)))): 
		self.view.play("move side")
	else:
		if (self.body.velocity.y < 0): self.view.play("move up")
		else: self.view.play("move down")

## The last method called when the state is transitioned out of
func exit() -> void:
	pass
	
## Updates the animation's flipping state
func update(_delta:float) -> void:
	self.view.flip_h = self.body.velocity.x < 0
	self.enter()

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(delta:float) -> void:
	self.body.move_and_slide()
	
