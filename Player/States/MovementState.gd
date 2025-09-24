class_name MovementState
extends State

@export var view:AnimatedSprite2D = null
@export var body:CharacterBody2D
@export var area2DCollision:CollisionShape2D
@onready var physics:PlayerPhysics


func _ready() -> void:
	self.physics = preload("res://Scripts/Resources/DefaultPhysics.tres")
	
## The first method called when the state is transitioned into
func enter() -> void:
	var prefix:String = "move"
	
	if (self.view.animation.contains("lift")): prefix = "movelift"
	if (self.view.animation.contains("push")): prefix = "push"
		
	if ((is_equal_approx(self.body.velocity.y, 0.0))
		and (not (is_equal_approx(self.body.velocity.x, 0.0)))): 
		self.view.play(prefix + " side")
	else:
		if (self.body.velocity.y < 0): self.view.play(prefix + " up")
		elif (self.body.velocity.y > 0): self.view.play(prefix + " down")

## The last method called when the state is transitioned out of
func exit() -> void:
	
	if (self.view.animation.contains("lift")):
		self.view.play("idlelift " + self.view.animation.split(" ")[1].to_lower())
	else:
		self.view.play("idle " + self.view.animation.split(" ")[1].to_lower()) 
	
func canEnter() -> bool:
	if (self.view.animation.contains("idle") || self.view.animation.contains("push")): return true
	else:
		if (self.view.animation.contains("lift") and not (self.view.is_playing())): return true
		if (self.view.animation.contains("throw") and not (self.view.is_playing())): return true
	return false

## Updates the animation's flipping state
func update(_delta:float) -> void:
	self.view.flip_h = self.getManager().direction.x < 0
	self.enter() ## Sets run animation
	
	self.area2DCollision.position = self.getManager().direction * 16

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(_delta:float) -> void:
	self.accelerate(self.getManager().direction, _delta)
	self.body.move_and_slide()
	
## Sets the player's velocity to increase or decrease based on the given direction (-1 left, 1 right)
func accelerate(direction:Vector2i, delta:float) -> void:
	if direction != Vector2i.ZERO:
		self.body.velocity.x = move_toward(self.body.velocity.x, direction.x * self.physics.maxSpeed, self.physics.acceleration * delta) 
		self.body.velocity.y = move_toward(self.body.velocity.y, direction.y * self.physics.maxSpeed, self.physics.acceleration * delta)

## Decreases the player's velocity. This function should only be called after the player
## stops pressing a direction.
#func decelerate(delta:float) -> void:
	#if (not self.body.velocity.is_equal_approx(Vector2i.ZERO)):
		#var deceleration:float = self.physics.deceleration
		#self.body.velocity.x = move_toward(self.body.velocity.x, 0, deceleration * delta)
		#self.body.velocity.y = move_toward(self.body.velocity.y, 0, deceleration * delta)
