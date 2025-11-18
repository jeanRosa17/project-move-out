extends RigidBody2D

class_name Furniture

## Update to be $AudioStreamPlayer2D
@onready var audioPlayer:FurnitureAudio = get_parent().get_node("Push_Pull Audio")
@onready var area_detector: Area2D = $AreaDetector
@onready var area_shape: CollisionShape2D = $AreaDetector/CollisionShape2D

@export var canLift:bool = false
@export var canPush:bool
@export var canPull:bool
@export var dialogueTag:DialogueTag = preload("res://Scripts/Dialogue/nullDialogue.tres")
@onready var sprite_2d: Sprite2D = $Sprite2D
var isGhost: bool = false


var isLifting: bool = false
var isPushing: bool = false


var player: CharacterBody2D

var distanceFromPlayer:float

var objects: Array[Node2D] = []
var ghostTween = null

@export var liftPosition:Vector2

func _process(delta: float) -> void:
	
	
	if (self.isGhost):
		self.ghostTween = self.get_tree().create_tween()
		self.ghostTween.tween_property(self, "modulate:a", 0, 1.0).from(1.0)
		self.ghostTween.set_delay(0.2)
		self.ghostTween.tween_property(self, "modulate:a", 1.0, 1.0).from(0.0)
		self.ghostTween.set_loops()


func _physics_process(_delta: float) -> void:
	if (isPushing):
		var dir = player.velocity.normalized()
		if (dir.length() > 0.1):
				update_detector_direction(dir)
		if (objects.is_empty()):
			collision_layer = 0
			linear_velocity = linear_velocity.lerp(player.velocity, 0.4)
		else:
			self.collision_layer = 2;
			linear_velocity = Vector2.ZERO
		## check to see if player is detached from object
		if (position.distance_to(player.position) > 45):
				exitPush()

func changeToAltArt() -> void:
	var temp = self.sprite_2d.texture
	self.sprite_2d.texture = self.altArt
	self.altArt = temp

func update_detector_direction(direction: Vector2) -> void:
	if (abs(direction.x) > abs(direction.y)):
		if (direction.x > 0):
			area_detector.position = Vector2(5, 0)
		else:
			area_detector.position = Vector2(-5, 0)
	else:
		if (direction.y > 0):
			area_detector.position = Vector2(0, 5)
		else:
			area_detector.position = Vector2(0, -5)

func get_canLift() -> bool:
	return canLift

## Reparents this Furniture to the given CharacterBody
func enterLift(body:CharacterBody2D) -> void:
	
	self.remove_from_group("Furniture")
	self.collision_layer = 1;
	self.collision_mask = 6;
	# lift position is not a real thing right now
	self.position = body.position + self.liftPosition
	self.reparent(body)
	self.isLifting = true
	


	self.get_node("Collision").disabled = true
	
	# create copy of sprite for ghosting display
	var ghost:Sprite2D = self.get_child(0).duplicate()
	var area:Area2D = Area2D.new()
	var collider:CollisionShape2D = self.get_child(1).duplicate()
	ghost.add_child(area)
	area.add_child(collider)
	area.collision_layer = 0
	body.find_child("Detector").get_child(0).add_child(ghost)
	
	#ghost.isGhost = true
	
		#play pickup sound
	audioPlayer.pick_up_noise()
	

## Returns this Furniture back to not being held
func exitLift() -> void:
	## check if youll be able to put down the object
   
	var body:CharacterBody2D = self.get_parent()
	
	
	var ghost:Node2D = body.find_child("Detector").get_child(0).get_child(0)
	print("ghost global pos = ", ghost.global_position)
	var pos:Vector2 = ghost.global_position
	
	
	## this is where the ghosting doesnt line up
	var col:Area2D = ghost.get_child(0)
	
	var bodies:Array[Node2D] = col.get_overlapping_bodies()
	
	var canDrop:bool = true;
	
	for i in range(bodies.size()):
			if (bodies[i].is_in_group("Furniture") || bodies[i].is_in_group("Immovable Object")):
				canDrop = false
	
	# put down object
	if (canDrop):
		ghost.queue_free()
		body.remove_child(self)
		body.add_sibling(self)
		self.get_node("Collision").disabled = false
		self.position = pos
		self.collision_layer = 2;
		self.collision_mask = 7;
		self.isLifting = false
		self.add_to_group("Furniture")
		audioPlayer.put_down_noise()
	
	
func enterPush(body: CharacterBody2D) -> void:
	print("entered pushing")
	self.player = body
	self.collision_layer = 0
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

func canPutDown() -> void: #change to be Vector2
	pass

func _on_area_detector_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if (body.is_in_group("World Bounds") && self.isPushing):
		print("cannot push (wall)")
		print(body.name)
		againstObject(body)
	elif (body.is_in_group("Furniture") && body != self && self.isPushing):
		print("cannot push (furniture)")
		print(body.name)
		againstObject(body)
	pass # Replace with function body.

func _on_area_detector_body_shape_exited(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if (body.is_in_group("World Bounds") && self.isPushing):
		print("can push (off wall)")
		relieveObject(body)
	elif(body.is_in_group("Furniture") && body != self && self.isPushing):
		print("can push (off furniture)")
		print(body.name)
		relieveObject(body)
	pass # Replace with function body.
