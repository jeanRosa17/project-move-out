class_name MovementState
extends State


@export var body:CharacterBody2D
@export var area2DCollision:CollisionShape2D

@onready var manager:StateManager = self.getManager()

@onready var physics:PlayerPhysics

@export var walkSound:Walk_Sound

var lastFrame:int = 0



func _ready() -> void:
	self.physics = preload("res://Scripts/Resources/DefaultPhysics.tres")
	
	if (walkSound == null):
		walkSound = self.get_parent().get_parent().find_child("Walk Sound")

func canEnter() -> bool:
	return (body as Player).canControl


func enter() -> void:
	pass


## The last method called when the state is transitioned out of
func exit() -> void:
	pass

## Flips the Player's Script when they move left or right. Additionally, it 
## sets the position of Player's Detector's collision shape to always be 
## in front of where the player is looking.
func update(_delta:float) -> void:
	var prefix:String = "move"

	if (self.manager.hasFurniture):
		if (self.manager.furniture.isPushed):
			prefix = "pushing"
		if (self.manager.furniture.isLifted):
			prefix = "movelift"
	
	if (prefix == "pushing"):
		var dir:String = (self.manager.view as AnimatedSprite2D).animation.split(" ")[1]
		self.manager.view.play(prefix + " " + dir)
	
	else:
		if (self.manager.isSliding):
			prefix = "slide"
		
		if (self.manager.direction == Vector2.DOWN):
			self.manager.view.play(prefix + " down")
		
		if (self.manager.direction == Vector2.RIGHT):
			self.manager.view.play(prefix + " side")
			self.manager.view.flip_h = false
			
		if (self.manager.direction == Vector2.LEFT):
			self.manager.view.play(prefix + " side")
			self.manager.view.flip_h = true
			
		if (self.manager.direction == Vector2.UP):
			self.manager.view.play(prefix + " up")
	
		self.area2DCollision.position = self.getManager().direction * 20 
	
## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(_delta:float) -> void:
	if (manager.furniture && manager.furniture.isPushed):
		if (!manager.furniture.canMovePositiveX && manager.direction.x > 0):
			manager.direction.x = 0
			self.body.velocity.x = 0
			self.manager.furniture.linear_velocity.x = 0
		if (!manager.furniture.canMovePositiveY && manager.direction.y > 0):
			manager.direction.y = 0
			self.body.velocity.y = 0
			self.manager.furniture.linear_velocity.y = 0
		if (!manager.furniture.canMoveNegativeX && manager.direction.x < 0):
			manager.direction.x = 0
			self.body.velocity.x = 0
			self.manager.furniture.linear_velocity.x = 0
		if (!manager.furniture.canMoveNegativeY && manager.direction.y < 0):
			manager.direction.y = 0
			self.body.velocity.y = 0
			self.manager.furniture.linear_velocity.y = 0

	self.accelerate(manager.direction, _delta)
	self.body.move_and_slide()

## Sets the player's velocity to increase or decrease based on the given direction (-1 left, 1 right)
func accelerate(direction:Vector2i, delta:float) -> void:
	if direction != Vector2i.ZERO:
		self.body.velocity.x = lerp(self.body.velocity.x, (self.physics.maxSpeed * direction).x, self.physics.acceleration * delta)
		self.body.velocity.y = lerp(self.body.velocity.y, (self.physics.maxSpeed * direction).y, self.physics.acceleration * delta)
		
		
		#self.body.velocity.x = move_toward(self.body.velocity.x, direction.x * self.physics.maxSpeed, self.physics.acceleration * delta) 
		#self.body.velocity.y = move_toward(self.body.velocity.y, direction.y * self.physics.maxSpeed, self.physics.acceleration * delta)
		
		if(self.manager.furniture && self.manager.furniture.isPushed):
			self.manager.furniture.linear_velocity.x = move_toward(self.body.velocity.x, direction.x * self.physics.maxSpeed, self.physics.acceleration * delta) 
			self.manager.furniture.linear_velocity.y = move_toward(self.body.velocity.y, direction.y * self.physics.maxSpeed, self.physics.acceleration * delta)
			#self.body.velocity.x += delta * (move_toward(self.body.velocity.x, direction.x * self.physics.maxSpeed, self.physics.acceleration * delta)) 
			#self.body.velocity.y += delta * (move_toward(self.body.velocity.y, direction.y * self.physics.maxSpeed, self.physics.acceleration * delta))
		#
		
		#self.body.velocity.x = lerp(self.body.velocity.x, (self.physics.maxSpeed * direction).x, delta)
		#self.body.velocity.y = lerp(self.body.velocity.y, (self.physics.maxSpeed * direction).y, delta)
		
		#if (direction.x > 0):
			#self.body.velocity.x = clamp(self.body.velocity.x, 0, self.physics.maxSpeed)
		#elif (direction.x < 0):
			#self.body.velocity.x = clamp(self.body.velocity.x, -self.physics.maxSpeed, 0)
		#
		#if (direction.y > 0):
			#self.body.velocity.y = clamp(self.body.velocity.y, 0, self.physics.maxSpeed)
		#elif (direction.y < 0):
			#self.body.velocity.y = clamp(self.body.velocity.y, -self.physics.maxSpeed, 0)
		
func _on_new_animated_sprite_2d_frame_changed() -> void:
	var frame:int = self.getManager().view.frame
	if (frame == 3 || frame == 7):
		if (frame != lastFrame):
			walkSound.play()
	
	lastFrame = self.getManager().view.frame
