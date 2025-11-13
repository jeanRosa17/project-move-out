class_name MovementState
extends State


@export var body:CharacterBody2D
@export var area2DCollision:CollisionShape2D

@onready var physics:PlayerPhysics

@onready var walkSound:Walk_Sound

var lastFrame = 0



func _ready() -> void:
	self.physics = preload("res://Scripts/Resources/DefaultPhysics.tres")
	
	walkSound = self.get_parent().get_parent().find_child("Walk Sound")
	
	
func canEnter() -> bool:
	return super.canEnter()
	#if (self.getManager().wasPreviousState("Idle") || self.getManager().wasPreviousState("Push")): return true
	#else:
		#if (self.getManager().wasPreviousState("Lift") and not (self.getManager().view.is_playing())): return true
		#if (self.getManager().wasPreviousState("Throw") and not (self.getManager().view.is_playing())): return true
	#return false

## The first method called when the state is transitioned into
func enter() -> void:
	pass

## The last method called when the state is transitioned out of
func exit() -> void:
	if (self.getManager().wasPreviousState("Lift")):
		self.getManager().view.play("idlelift " + self.getManager().view.animation.split(" ")[1].to_lower())
	elif (self.getManager().wasPreviousState("Push")):
		self.getManager().view.play("push " + self.getManager().view.animation.split(" ")[1].to_lower()) 
	else:
		self.getManager().view.play("idle " + self.getManager().view.animation.split(" ")[1].to_lower()) 

## Updates the animation's flipping stateww
func update(_delta:float) -> void:
	
	self.getManager().view.flip_h = self.getManager().direction.x < 0
	self.enter() ## Sets run animation

	
	self.area2DCollision.position = self.getManager().direction * 16
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
		#prints(self.body.velocity, " v")

## Decreases the player's velocity. This function should only be called after the player
## stops pressing a direction.
#func decelerate(delta:float) -> void:
	#if (not self.body.velocity.is_equal_approx(Vector2i.ZERO)):
		#var deceleration:float = self.physics.deceleration
		#self.body.velocity.x = move_toward(self.body.velocity.x, 0, deceleration * delta)
		#self.body.velocity.y = move_toward(self.body.velocity.y, 0, deceleration * delta)


func _on_new_animated_sprite_2d_frame_changed() -> void:
	var frame = self.getManager().view.frame
	if (frame == 3 || frame == 7):
		if (frame != lastFrame):
			walkSound.play()
	
	lastFrame = self.getManager().view.frame
