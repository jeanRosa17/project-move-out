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

func enter() -> void:
	pass

## The last method called when the state is transitioned out of
func exit() -> void:
	var dir:String = self.getManager().view.animation.split(" ")[1].to_lower()
	
	if (self.getManager().wasPreviousState("Lift")):
		self.getManager().view.play("idlelift " + dir)
	
	elif (self.getManager().wasPreviousState("Push")):
		self.getManager().view.play("push " + dir) 
	
	else:
		self.getManager().view.play("idle " + dir) 

## Flips the Player's Script when they move left or right. Additionally, it 
## sets the position of Player's Detector's collision shape to always be 
## in front of where the player is looking.
func update(_delta:float) -> void:
	if not (self.manager.hasFurniture and self.manager.furniture.isPushed):
		self.area2DCollision.position = self.getManager().direction * 16
	
## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(_delta:float) -> void:
	if (manager.furniture && manager.furniture.isPushed):
		if (!manager.furniture.canMovePositiveX && manager.direction.x > 0):
			manager.direction.x = 0
			self.body.velocity.x = 0
		if (!manager.furniture.canMovePositiveY && manager.direction.y > 0):
			manager.direction.y = 0
			self.body.velocity.y = 0
		if (!manager.furniture.canMoveNegativeX && manager.direction.x < 0):
			manager.direction.x = 0
			self.body.velocity.x = 0
		if (!manager.furniture.canMoveNegativeY && manager.direction.y < 0):
			manager.direction.y = 0
			self.body.velocity.y = 0
			

	self.accelerate(manager.direction, _delta)
	self.body.move_and_slide()

## Sets the player's velocity to increase or decrease based on the given direction (-1 left, 1 right)
func accelerate(direction:Vector2i, delta:float) -> void:
	if direction != Vector2i.ZERO:
		self.body.velocity.x = move_toward(self.body.velocity.x, direction.x * self.physics.maxSpeed, self.physics.acceleration * delta) 
		self.body.velocity.y = move_toward(self.body.velocity.y, direction.y * self.physics.maxSpeed, self.physics.acceleration * delta)
		


func _on_new_animated_sprite_2d_frame_changed() -> void:
	var frame:int = self.getManager().view.frame
	if (frame == 3 || frame == 7):
		if (frame != lastFrame):
			walkSound.play()
	
	lastFrame = self.getManager().view.frame
