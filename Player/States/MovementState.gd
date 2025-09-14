class_name MovementState
extends State

@export var view:AnimatedSprite2D = null
@export var body:CharacterBody2D

## The first method called when the state is transitioned into
func enter() -> void:
	var prefix:String = "move"
	
	if (self.view.animation.contains("lift")): prefix = "movelift"
		
	if ((is_equal_approx(self.body.velocity.y, 0.0))
		and (not (is_equal_approx(self.body.velocity.x, 0.0)))): 
		self.view.play(prefix + " side")
	else:
		if (self.body.velocity.y < 0): self.view.play(prefix+" up")
		else: self.view.play(prefix + " down")

## The last method called when the state is transitioned out of
func exit() -> void:
	
	if (self.view.animation.contains("lift")):
		self.view.play("lift " + self.view.animation.split(" ")[1].to_lower())
		self.view.frame = 5
	#else:
		#self.view.play("idle " + self.view.animation.split(" ")[1].to_lower()) 
	
func canEnter() -> bool:
	if (self.view.animation.contains("idle")): return true
	else:
		if (self.view.animation.contains("lift") and not (self.view.is_playing())): return true
	
	return false

## Updates the animation's flipping state
func update(_delta:float) -> void:
	self.view.flip_h = self.body.velocity.x < 0
	self.enter()

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(delta:float) -> void:
	self.body.move_and_slide()
	
