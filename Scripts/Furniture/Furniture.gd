extends RigidBody2D

class_name Furniture

## Update to be $AudioStreamPlayer2D
@onready var audioPlayer:FurnitureAudio = get_parent().get_node("AudioStreamPlayer2D")

@export var canLift:bool = false
@export var canPush:bool
@export var canPull:bool
@export var weight:int
@export var dialogueTag:DialogueTag = preload("res://Scripts/Dialogue/nullDialogue.tres")

var isLifting: bool = false
var isPushing: bool = false


var player: CharacterBody2D

var distanceFromPlayer:float

var objects: Array[Node2D] = []

@export var liftPosition:Vector2

func _physics_process(_delta: float) -> void:
	if (isPushing):
		if (objects.is_empty()):
			collision_layer = 0
		else:
			self.collision_layer = 2;
		linear_velocity = linear_velocity.lerp(player.velocity, 0.4)
		## check to see if player is detached from object
		if (position.distance_to(player.position) > 45):
				exitPush()


func get_canLift() -> bool:
	return canLift

## Reparents this Furniture to the given CharacterBody
func enterLift(body:CharacterBody2D) -> void:
	if (isLifting):
		self.exitLift()
	else:
		self.collision_layer = 1;
		self.collision_mask = 6;
		self.position = body.position + self.liftPosition
		self.reparent(body)
		self.isLifting = true

## Returns this Furniture back to not being held
func exitLift() -> void:
	var body:CharacterBody2D = self.get_parent()
	body.remove_child(self)
	body.add_sibling(self)
	self.position = body.position + self.liftPosition
	self.collision_layer = 2;
	self.collision_mask = 7;
	self.isLifting = false
	
func enterPush(body: CharacterBody2D) -> void:
	print("entered pushing")
	self.player = body
	self.collision_layer = 0;
	audioPlayer.push_sound(self)
	distanceFromPlayer = position.distance_to(player.position)
	self.isPushing = true

func exitPush()-> void:
	print("exited pushing")
	self.player = null
	self.collision_layer = 2;
	self.isPushing = false
	self.linear_velocity = Vector2.ZERO

func againstObject(newObject: Node2D) -> void:
	objects.append(newObject)
	print("added object: ")
	print(newObject.name)
	pass

func relieveObject(newObject: Node2D) -> void:
	if (objects.has(newObject)):
		objects.erase(newObject)
		print("removed object: ")
		print(newObject.name)
	pass

func _on_area_detector_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if (body.is_in_group("World Bounds") && self.isPushing):
		print("cannot push")
		againstObject(body)
	elif (body.name != "Player" && self.isPushing):
		print(body.name)
	pass # Replace with function body.

func _on_area_detector_body_shape_exited(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if (body.is_in_group("World Bounds") && self.isPushing):
		print("can push")
		relieveObject(body)
	elif(body.name != "Player" && self.isPushing):
		print(body.name)
	pass # Replace with function body.
