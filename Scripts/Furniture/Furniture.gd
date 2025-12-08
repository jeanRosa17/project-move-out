extends RigidBody2D

class_name Furniture

## Update to be $AudioStreamPlayer2D
@onready var audioPlayer: FurnitureAudio = get_tree().root.find_child("Push_Pull Audio", true, false)
@onready var area_detector: Area2D = $AreaDetector
@onready var area_shape: CollisionShape2D = $AreaDetector/CollisionShape2D

@export var canLift:bool = false
@export var canPush:bool = false
@export var canPull:bool = false

var isLifted: bool = false
var isPushed: bool = false
var canBeDropped: bool = false

@export var dialogueTag:DialogueTag = preload("res://Scripts/Dialogue/nullDialogue.tres")

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var ghostSprite: Sprite2D = sprite_2d.duplicate()


@export var rotatedVersion:Node2D


var player: CharacterBody2D

var distanceFromPlayer:float

var objects: Array[Node2D] = []
var ghostTween:Tween = null
var placementTween:Tween = null
var floatXTween:Tween = null
var floatYTween:Tween = null
var floatTiltTween:Tween = null

@export var liftPosition:Vector2 = Vector2(0, -16)


func _physics_process(_delta: float) -> void:
	if (self.ghostSprite != null):
		self.ghostSprite.self_modulate = (Color.GREEN if (self.canBeDropped) else Color.RED)

	if (self.isPushed):
		var dir:Vector2 = self.player.velocity.normalized()
		
		if (dir.length() > 0.1): self.update_detector_direction(dir)

		if (objects.is_empty()):
			collision_layer = 0
			linear_velocity = linear_velocity.lerp(player.velocity, 0.4)
		else:
			self.collision_layer = 2;
			linear_velocity = Vector2.ZERO
		
		## check to see if player is detached from object
		if (position.distance_to(player.position) > 45): self.exitPush()



func update_detector_direction(direction: Vector2) -> void:
	if (abs(direction.x) > abs(direction.y)):
		if (direction.x > 0): area_detector.position = Vector2(liftPosition.y, 0)
		else: area_detector.position = liftPosition
		
	else:
		if (direction.y > 0): area_detector.position = Vector2(0, liftPosition.y)
		else: area_detector.position = liftPosition

## Ses the Ghost as a Sprite
func createGhostSprite(body:CharacterBody2D) -> void:
	var area:Area2D = Area2D.new()
	area.collision_layer = self.collision_layer
	area.collision_mask = self.collision_mask
	area.body_entered.connect(func () -> void: self.ghostSprite.self_modulate = Color.RED)
	area.body_exited.connect(func () -> void: self.ghostSprite.self_modulate = Color.GREEN)
	
	var collider:CollisionShape2D = self.get_child(1).duplicate()
	self.ghostSprite = sprite_2d.duplicate()
	ghostSprite.add_child(area)
	area.add_child(collider)
	#area.collision_layer = 0
	body.find_child("Detector").get_child(0).add_child(ghostSprite)
	
	self.ghostTween = self.get_tree().create_tween()
	self.ghostTween.tween_property(ghostSprite, "self_modulate:a", 0, 1.0).from(1.0).set_delay(0.1)
	#self.ghostTween.tween_property(ghostSprite, "self_modulate:a", 1.0, 1.0).from(0.0).set_delay(0.1)
	self.ghostTween.set_loops()


#region Tween Animation
# Starts the hovering tween animation
func startLiftingTween() -> void:
	var tween: Tween = create_tween()
	self.floatXTween = get_tree().create_tween()
	self.floatYTween = get_tree().create_tween()
	self.floatTiltTween = get_tree().create_tween()
	
	tween.tween_property(self, "scale", Vector2(0.3, 0.3), 0.4)
	
	self.floatXTween.tween_property(self, "position:x", -8, 0.4).set_delay(0.05)
	self.floatXTween.tween_property(self, "position:x", 8, 0.3).set_delay(0.05)
	self.floatXTween.set_loops().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	
	self.floatYTween.tween_property(self, "position:y", -8, 0.2).set_delay(0.05)
	self.floatYTween.tween_property(self, "position:y", 4, 0.3).set_delay(0.05)
	self.floatYTween.set_loops().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	
	self.floatTiltTween.tween_property(self, "rotation_degrees", -4, 0.5).set_delay(0.4)
	self.floatTiltTween.tween_property(self, "rotation_degrees", 4, 0.5).set_delay(0.8)
	self.floatTiltTween.set_loops().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)

# Stops all lifting tweens
func killLiftingTween() -> void:
	self.floatXTween.kill()
	self.floatYTween.kill()
	self.floatTiltTween.kill()
	
	self.floatXTween = null
	self.floatYTween = null
	self.floatTiltTween = null
	
	self.rotation_degrees = 0

#endregion

#region Lift / Pushing

func enterLift(body:CharacterBody2D) -> void:
	self.remove_from_group("Furniture")
	self.collision_layer = 1;
	self.collision_mask = 6;
	self.position = body.position + self.liftPosition
	self.reparent(body)
	self.isLifted = true
	self.startLiftingTween()
	self.get_node("Collision").disabled = true
	self.createGhostSprite(body)

	audioPlayer.pick_up_noise()
	self.player = self.get_parent()

func exitLift() -> void:
	print("ghost global pos = ", ghostSprite.global_position)
	
	self.killLiftingTween()
	
	self.ghostSprite.queue_free()
	self.player.remove_child(self)
	self.player.add_sibling(self)
	self.get_node("Collision").disabled = false
	self.position = ghostSprite.global_position
	self.collision_layer = 2;
	self.collision_mask = 7;
	self.isLifted = false
	
	self.player = null
	self.add_to_group("Furniture")
	audioPlayer.put_down_noise()

func enterPush(body: CharacterBody2D) -> void:
	print("entered pushing")
	self.player = body
	self.collision_layer = 0
	audioPlayer.push_sound(self)
	distanceFromPlayer = position.distance_to(player.position)
	self.isPushed = true

func exitPush()-> void:
	print("exited pushing")
	self.player = null
	self.collision_layer = 2;
	self.isPushed = false
	self.linear_velocity = Vector2.ZERO
#endregion

#region Signals
func againstObject(newObject: Node2D) -> void:
	objects.append(newObject)
	print("added object: ")
	print(newObject.name)

func relieveObject(newObject: Node2D) -> void:
	if (objects.has(newObject)):
		objects.erase(newObject)
		print("removed object: ")
		print(newObject.name)

func _on_area_detector_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if (body.is_in_group("World Bounds") && self.isPushed):
		print("cannot push (wall)")
		print(body.name)
		againstObject(body)
	elif (body.is_in_group("Furniture") && body != self && self.isPushed):
		print("cannot push (furniture)")
		print(body.name)
		againstObject(body)
	pass # Replace with function body.

func _on_area_detector_body_shape_exited(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if (body.is_in_group("World Bounds") && self.isPushed):
		print("can push (off wall)")
		relieveObject(body)
	elif(body.is_in_group("Furniture") && body != self && self.isPushed):
		print("can push (off furniture)")
		print(body.name)
		relieveObject(body)
	pass # Replace with function body.
#endregion

#func rotateFurniture() -> void:
	#if (rotatedVersion != null):
		#print("rotate")
		#var me:Furniture = self
		#self.replace_by(rotatedVersion)
		#rotatedVersion = me
