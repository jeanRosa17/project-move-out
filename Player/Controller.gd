class_name Player
extends CharacterBody2D

@onready var manager:StateManager = $StateManager
@onready var view:AnimatedSprite2D = $AnimatedSprite2D
@onready var physics:PlayerPhysics
@onready var area:Area2D 
var movement:MovementComponent

var currentState:State

var furniture:StaticBody2D

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

## Handles the "Move" set of Inputs and moves the character accordingly using
## its MovementComponent.
@warning_ignore("narrowing_conversion")
func handleMovement(delta:float) -> void:
	if (Input.is_action_pressed("MoveLeft") \
	or Input.is_action_pressed("MoveRight")
	or Input.is_action_pressed("MoveDown")
	or Input.is_action_pressed("MoveUp")):
		var direction:Vector2i = Vector2i(clampf(Input.get_axis("MoveLeft", "MoveRight"), -1, 1), \
											clampf(Input.get_axis("MoveUp", "MoveDown"), -1, 1))
		
		self.movement.accelerate(direction, delta)
		
		if (self.manager.currentState.name != "Move" && self.manager.currentState.name != "Lift"):
			self.manager.currentState.transitioned.emit(self.manager.currentState, "Move")
	
	else:
		self.movement.decelerate(delta)
		if (self.manager.currentState.name == "Move" && self.manager.currentState.name != "Lift"):
			self.manager.currentState.transitioned.emit(self.manager.currentState, "Idle")

## Handles the "Lift" set of Inputs and triggers a Carryable item up
func handleLift(_delta:float) -> void:
	if (Input.is_action_just_pressed("Lift")):
		
		# Luna wrote this block just removing it for now
		#if ((self.manager.currentState.name == "Throw") or (self.view.animation.contains("Lift"))):
			#self.manager.currentState.transitioned.emit(self.manager.currentState, "Throw")
		#else: 
			#(self.manager.currentState.name != "Lift")
			#self.manager.currentState.transitioned.emit(self.manager.currentState, "Lift")
		#if (self.manager.currentState.name = "Lift"):
	
		if (self.manager.currentState.name != "Lift"):
			
			## if toucning liftable object, do lift animation and child object. 
			## For lift, object would be held above players head so it doesnt collide with anything. (turning off its collider)
			if (furniture) :
				print ("pick up")
				self.manager.currentState.transitioned.emit(self.manager.currentState, "Lift")
				
				furniture.position = self.position
				furniture.collision_layer = 4;
				furniture.reparent(self)
		
		elif (self.view.animation.contains("lift")):
			print("put down")
			furniture.reparent(self.get_parent())
			furniture.collision_layer = 1;
			self.manager.currentState.transitioned.emit(self.manager.currentState, "Throw")
			
			
## Handles "Push" and "Pull"
func handlePushPull(delta:float) -> void:
	if (Input.is_action_just_pressed("Push")):
		self.manager.currentState.transitioned.emit(self.manager.currentState, "Push")
		print("Push")

# Assigns furniture to most recently touched object
func _on_area_2d_area_entered(area: Area2D) -> void:
	
	furniture = area.get_parent()
	print("furniture = " + furniture.name)
	
	
# Unassigns furniture on exit
func _on_area_2d_area_exited(area: Area2D) -> void:
	furniture = null;
