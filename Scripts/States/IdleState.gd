class_name IdleState
extends State

@export var body:CharacterBody2D = null
@onready var physics:PlayerPhysics

func _ready() -> void:
	self.physics = preload("res://Scripts/Resources/DefaultPhysics.tres")


## The first method called when the state is transitioned into
func enter() -> void: 
	var dir:String = self.getManager().view.animation.split(" ")[1].to_lower()
	
	if not (self.getManager().hasFurniture):
		self.getManager().view.play("idle " + dir)
	else:
		if (self.getManager().furniture.isPushed):
			self.getManager().view.play("pushing " + dir)
			self.getManager().view.stop()
		elif (self.getManager().furniture.isLifted):
			self.getManager().view.play("idlelift " + dir)
		else:
			self.getManager().view.play("idle " + dir)

## The last method called when the state is transitioned out of
func exit() -> void:
	pass
	
## Constantly checks for input from the user and changes state.
func update(_delta:float) -> void:
	pass

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(_delta:float) -> void:
	#self.body.velocity.x = lerpf(self.body.velocity.x, 0.0, delta * self.physics.deceleration)
	#self.body.velocity.y = lerpf(self.body.velocity.y, 0.0, delta * self.physics.deceleration)
	
	self.body.velocity = Vector2.ZERO
	if (self.getManager().furniture && self.getManager().furniture.isPushed):
		pass
		#self.getManager().furniture.linear_velocity = Vector2.ZERO
	#print(self.body.velocity)
	#self.decelerate(delta)
	self.body.move_and_slide()
	
## Decreases the player's velocity. This function should only be called after the player
## stops pressing a direction.
func decelerate(delta:float) -> void:
	if (not self.body.velocity.is_zero_approx()):
		var _direction:Vector2 = self.getManager().direction
		self.body.velocity.x -= delta * (move_toward(self.body.velocity.x, -100, self.physics.deceleration * delta)) 
		self.body.velocity.y -= delta * (move_toward(self.body.velocity.y, -100, self.physics.deceleration * delta))
	else:
		self.body.velocity = Vector2.ZERO
