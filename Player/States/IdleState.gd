class_name IdleState
extends State

@export var view:AnimatedSprite2D = null
@export var body:CharacterBody2D = null

## The first method called when the state is transitioned into
func enter() -> void: 
	var dir:String = self.view.animation.split(" ")[1].to_lower()
	
	if (self.view.animation.contains("idle")): return
	
	self.view.play("idle " + dir)
	#if (self.view.animation.contains("lift")):
		#if not (self.view.is_playing()):
			#self.view.play("lift " + dir)
	#else: 
		#self.view.play("idle " + dir)
	
	#self.view.play("idle down")

## The last method called when the state is transitioned out of
func exit() -> void:
	pass
	
## Constantly checks for input from the user and changes state.
func update(_delta:float) -> void:
	pass

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(delta:float) -> void:
	self.body.velocity = Vector2.ZERO
	#pass
	#self.body.move_and_slide()
	
