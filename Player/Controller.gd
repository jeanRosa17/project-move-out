class_name Player
extends CharacterBody2D

@onready var manager:StateManager = $StateManager
@onready var view:AnimatedSprite2D = $AnimatedSprite2D
@onready var physics:PlayerPhysics
@onready var area:Area2D 
var movement:MovementComponent

var currentState:State

signal newFurniture(furniture:Furniture)


const Date = preload("res://Objects/Furniture.gd") #?

func _ready() -> void:
	self.physics = preload("res://Scripts/Resources/DefaultPhysics.tres")
	self.movement = MovementComponent.new(self, self.physics)
	self.manager.start()
	
	
func _process(delta:float) -> void:
	if (manager == null):
		Exception.new("Manager for Controller can't be null.")
		
	self.currentState = manager.currentState
	self.handleMovement(delta)
	self.handleLift(delta)
	self.handlePushPull(delta)

## Handles the "Move" set of Inputs and moves the character accordingly using
## its MovementComponent.
@warning_ignore("narrowing_conversion")
func handleMovement(delta:float) -> void:
	if (Input.is_action_pressed("MoveLeft") \
	or Input.is_action_pressed("MoveRight")
	or Input.is_action_pressed("MoveDown")
	or Input.is_action_pressed("MoveUp")):
		var direction:Vector2i = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
		
		self.movement.accelerate(direction, delta)
		
		if (self.manager.getStateName() != "Move" && self.manager.getStateName() != "Lift"):
			self.manager.changeState("Move")
			
		if (self.manager.getStateName() == "Lift"):
			self.manager.changeState("Move")
	
	else:
		self.movement.decelerate(delta)
		
		if (self.manager.getStateName() == "Move" && self.manager.getStateName() != "Lift"):
			self.manager.changeState("Idle")
		if (self.manager.getStateName() == "Push"):
			self.manager.changeState("Idle")
		

## Handles the "Lift" set of Inputs and enters the Lift State if
## 1. Lift is inputed 
## 2. node from the Furniture Group is around the player
## 3. Furniture node can be lifted 
func handleLift(_delta:float) -> void:
	if (Input.is_action_just_pressed("Lift")):
		if (self.view.animation.contains("lift")):
			self.manager.changeState("Throw")
			
		elif (self.manager.getStateName() != "Lift"): self.manager.changeState("Lift")
			
			
## Handles "Push" and "Pull"
func handlePushPull(delta:float) -> void:
	if (Input.is_action_pressed("Push-Pull")):
		if (self.manager.getStateName() != "Push"): self.manager.changeState("Push")
		
		print("attempting to push")
		
		#if (furniture && furniture.canPush):
			#print("pushing object")
#
			##var input_vector = Input.get_vector("MoveLeft", "MoveRight", "MoveUp", "MoveDown")
			##
			##var move_dircetion = input_vector.normalized()
			##
			###furniture.collision_layer = 4;
			##furniture.reparent(self)
			##move_and_slide() #move_dircetion, Vector2(0,0), false, 4, PI/4, false
			#
			##for i in get_slide_collision_count():
				##var collision = get_slide_collision(i)
				##if collision.collider.is_in_group("furniture"):
					##collision.collider.apply_central_impulse(-collision.normal * inertia)
			#self.manager.changeState("Push")
			#
			#print("Pussssssssssssh")
		#elif(furniture):
			#print("To heavy to push")
			#furniture.reparent(self)


func _on_area_2d_area_exited(area: Area2D) -> void:
	pass # Replace with function body.
