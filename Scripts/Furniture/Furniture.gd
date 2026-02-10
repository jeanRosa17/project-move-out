extends RigidBody2D

class_name Furniture

## Update to be $AudioStreamPlayer2D
@onready var audioPlayer: FurnitureAudio = get_tree().root.find_child("Push_Pull Audio", true, false)
@onready var area_detector: Area2D = $AreaDetector
@onready var area_shape: CollisionShape2D = $AreaDetector/CollisionShape2D


@export var canLift:bool = false
@export var canPush:bool = false
@export var canPull:bool = false
@export var canRotate:bool
@export var rotatedVersion:Furniture
var rotated: int = 0

@export var weight:int = 0
@export var dialogueTag:DialogueTag = preload("res://Scripts/Dialogue/nullDialogue.tres")
@export var liftPosition:Vector2 = Vector2(0, -16)

var isLifted: bool = false
var isPushed: bool = false
var canBeDropped: bool = true ## Changed to true so that a player can immediately pick up and drop something



@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var ghostSprite: Sprite2D = sprite_2d.duplicate()

@onready var collider:CollisionShape2D = $Collision


var player: CharacterBody2D

var distanceFromPlayer:float

var objects: Array[Node2D] = []

var tObjects: Array[Node2D] = []
var bObjects: Array[Node2D] = []
var rObjects: Array[Node2D] = []
var lObjects: Array[Node2D] = []

var ghostTween:Tween = null
var placementTween:Tween = null
var floatXTween:Tween = null
var floatYTween:Tween = null
var floatTiltTween:Tween = null

var canMoveNegativeX:bool = true
var canMoveNegativeY:bool = true
var canMovePositiveX:bool = true
var canMovePositiveY:bool = true

@onready var areaBot:Area2D = Area2D.new()
@onready var areaTop:Area2D = Area2D.new()
@onready var areaRight:Area2D = Area2D.new()
@onready var areaLeft:Area2D = Area2D.new()

@warning_ignore("untyped_declaration")
func _ready() -> void:
	
	self.createAdditionalCollisions()
	
	areaLeft.body_entered.connect(_on_left_area_entered)
	areaLeft.body_exited.connect(_on_left_area_exited)
	
	self.lock_rotation = true

func createAdditionalCollisions() -> void:
	collider.debug_color = Color.GREEN
	var shape:Shape2D = collider.shape
	@warning_ignore("untyped_declaration") var rect = shape.get_rect()
	
	@warning_ignore("untyped_declaration") var shapeBot = CollisionShape2D.new()
	@warning_ignore("untyped_declaration") var shapeBotResource = RectangleShape2D.new()
	shapeBotResource.size = Vector2(rect.size.x - 2, 1)
	shapeBot.position = Vector2(collider.position.x, collider.position.y + (rect.size.y / 2))
	shapeBot.shape = shapeBotResource
	areaBot.collision_layer = 2
	areaBot.collision_mask = 7
	areaBot.name = "Bottom"
	areaBot.add_child(shapeBot)
	self.add_child(areaBot)

	areaBot.body_entered.connect(_on_bot_area_entered)
	areaBot.body_exited.connect(_on_bot_area_exited)
	
	
	@warning_ignore("untyped_declaration") var shapeTop = CollisionShape2D.new()
	@warning_ignore("untyped_declaration") var shapeTopResource = RectangleShape2D.new()
	shapeTopResource.size = Vector2(rect.size.x - 2, 1)
	shapeTop.position = Vector2(collider.position.x, collider.position.y - (rect.size.y / 2))
	shapeTop.shape = shapeTopResource
	areaTop.collision_layer = 2
	areaTop.collision_mask = 7
	areaTop.name = "Top"
	areaTop.add_child(shapeTop)
	self.add_child(areaTop)
	
	areaTop.body_entered.connect(_on_top_area_entered)
	areaTop.body_exited.connect(_on_top_area_exited)
	
	@warning_ignore("untyped_declaration") var shapeRight = CollisionShape2D.new()
	@warning_ignore("untyped_declaration") var shapeRightResource = RectangleShape2D.new()
	shapeRightResource.size = Vector2(1, rect.size.y - 2)
	shapeRight.position = Vector2(collider.position.x + (rect.size.x / 2), collider.position.y)
	shapeRight.shape = shapeRightResource
	areaRight.collision_layer = 2
	areaRight.collision_mask = 7
	areaRight.name = "Right"
	areaRight.add_child(shapeRight)
	self.add_child(areaRight)
	
	areaRight.body_entered.connect(_on_right_area_entered)
	areaRight.body_exited.connect(_on_right_area_exited)
	
	
	@warning_ignore("untyped_declaration") var shapeLeft = CollisionShape2D.new() 
	@warning_ignore("untyped_declaration") var shapeLeftResource = RectangleShape2D.new()
	shapeLeftResource.size = Vector2(1, rect.size.y - 2 )
	shapeLeft.position = Vector2(collider.position.x - (rect.size.x / 2), collider.position.y)
	shapeLeft.shape = shapeLeftResource
	areaLeft.collision_layer = 2
	areaLeft.collision_mask = 7
	areaLeft.name = "Left"
	areaLeft.add_child(shapeLeft)
	self.add_child(areaLeft)

func _physics_process(_delta: float) -> void:
	if (self.ghostSprite != null):
		self.ghostSprite.self_modulate = (Color.GREEN if (self.canBeDropped) else Color.RED)
		
		if (self.player):
			ghostSprite.position = self.player.manager.direction * 20
		
	if (self.isPushed):
		
		#var dir:Vector2 = self.player.velocity.normalized()
		
		
		# if not touching anything, proceed as normal
		#if (objects.is_empty()):
			#self.collision_layer = 0
			#linear_velocity = linear_velocity.lerp(player.velocity, 1)
			#
			#canMoveNegativeX = true
			#canMoveNegativeY = true
			#canMovePositiveX = true
			#canMovePositiveY = true
			#


		linear_velocity = linear_velocity.lerp(player.velocity, 1)
	
	if(self.player):
		if(self.position.distance_to(self.player.position) > 40):
			if(self.isPushed):
				self.exitPush()
			if(self.isLifted):
				self.exitLift()

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
	
	#var collider:CollisionShape2D = self.get_child(1).duplicate()
	self.ghostSprite = sprite_2d.duplicate()
	#ghostSprite.add_child(area)
	#area.add_child(collider)
	#area.collision_layer = 0
	#body.find_child("Detector").get_child(0).add_child(ghostSprite)
	body.add_child(ghostSprite)
	ghostSprite.position = (body as Player).manager.direction * 12
	self.ghostTween = self.get_tree().create_tween()
	self.ghostTween.tween_property(ghostSprite, "self_modulate:a", 0, 1.0).from(1.0).set_delay(0.1)
	self.ghostTween.tween_property(ghostSprite, "self_modulate:a", 1.0, 1.0).from(0.0).set_delay(0.1)
	self.ghostTween.set_loops()


#region Tweens  Animation
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
	
	#self.floatTiltTween.tween_property(self, "rotation_degrees", -4, 0.5).set_delay(0.4)
	#self.floatTiltTween.tween_property(self, "rotation_degrees", 4, 0.5).set_delay(0.8)
	#self.floatTiltTween.set_loops().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)

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
	#print("ghost global pos = ", ghostSprite.global_position)
	
	self.killLiftingTween()
	
	
	self.player.remove_child(self)
	self.player.add_sibling(self)
	self.get_node("Collision").disabled = false
	self.position = ghostSprite.global_position
	self.ghostSprite.queue_free()
	self.collision_layer = 2;
	self.collision_mask = 7;
	self.isLifted = false
	
	self.player = null
	self.add_to_group("Furniture")
	audioPlayer.put_down_noise()

func enterPush(body: CharacterBody2D) -> void:
	print("entered pushing")
	self.player = body
	print(player.name)
	self.collision_layer = 0
	audioPlayer.push_sound(self)
	#distanceFromPlayer = position.distance_to(player.position)
	self.isPushed = true

func exitPush()-> void:
	print("exited pushing")
	#self.player = null
	self.collision_layer = 2;
	self.isPushed = false
	self.linear_velocity = Vector2.ZERO
#endregion

func rotateObj() -> void:
	#if (self.canRotate):
		#print("rotate")
		#@warning_ignore("untyped_declaration") var pos = self.global_position
		#if (self.rotated > 2):
			#self.rotated = 0
		#else:
			#self.rotated += 1
		#
		#var rect:Rect2 = self.sprite_2d.region_rect
		#self.sprite_2d.region_rect = Rect2(Vector2(rect.size.x * rotated, rect.position.y), rect.size)
		
	if (self.canRotate):
		print("rotate")
		@warning_ignore("untyped_declaration") var pos = self.global_position
		
		self.exitPush()
		self.visible = false
		self.collision_layer = 0
		self.collision_mask = 0
		
		rotatedVersion.global_position = pos
		rotatedVersion.reparent(self.get_parent())

		self.reparent(rotatedVersion)
		rotatedVersion.visible = true
		rotatedVersion.collision_layer = 2
		rotatedVersion.collision_mask = 7
		
		rotatedVersion.enterPush(player)
		

#region Signals
func againstObject(newObject: Node2D) -> void:
	objects.append(newObject)
	print("added object: ", newObject.name)
	

func relieveObject(newObject: Node2D) -> void:
	if (objects.has(newObject)):
		objects.erase(newObject)
		print("removed object: ")
		print(newObject.name)

func _on_area_detector_body_shape_entered(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if (body.is_in_group("World Bounds") && self.isPushed):
		print("cannot push (wall)")
		print(body.name)
		#againstObject(body)
	elif (body.is_in_group("Furniture") && body != self && self.isPushed):
		print("cannot push (furniture)")
		print(body.name)
		#againstObject(body)
	pass # Replace with function body.

func _on_area_detector_body_shape_exited(_body_rid: RID, body: Node2D, _body_shape_index: int, _local_shape_index: int) -> void:
	if (body == null):
		return
	if (body.is_in_group("World Bounds") && self.isPushed):
		print("can push (off wall)")
		#relieveObject(body)
	elif(body.is_in_group("Furniture") && body != self && self.isPushed):
		print("can push (off furniture)")
		print(body.name)
		#relieveObject(body)
	pass # Replace with function body.
#endregion

#region collisions

func _on_left_area_entered(body: Node2D) -> void:
	if (body.is_in_group("World Bounds") && self.isPushed):
		print("LEFT")
		canMoveNegativeX = false
		lObjects.append(body)
	elif(body.is_in_group("Furniture") && body != self && self.isPushed):
		print("LEFT")
		lObjects.append(body)
		canMoveNegativeX = false
	

func _on_right_area_entered(body: Node2D) -> void:
	if (body.is_in_group("World Bounds") && self.isPushed):
		print("RIGHT")
		rObjects.append(body)
		canMovePositiveX = false
	elif(body.is_in_group("Furniture") && body != self && self.isPushed):
		print("RIGHT")
		rObjects.append(body)
		canMovePositiveX = false
	
func _on_top_area_entered(body: Node2D) -> void:
	if (body.is_in_group("World Bounds") && self.isPushed):
		print("TOP")
		tObjects.append(body)
		canMoveNegativeY = false
	elif(body.is_in_group("Furniture") && body != self && self.isPushed):
		print("TOP")
		tObjects.append(body)
		canMoveNegativeY = false
	
func _on_bot_area_entered(body: Node2D) -> void:
	if (body.is_in_group("World Bounds") && self.isPushed):
		print("BOTTOM")
		bObjects.append(body)
		canMovePositiveY = false
	elif(body.is_in_group("Furniture") && body != self && self.isPushed):
		print("BOTTOM")
		bObjects.append(body)
		canMovePositiveY = false

func _on_left_area_exited(body: Node2D) -> void:
	if (lObjects.has(body)):
		lObjects.erase(body)
		if (lObjects.is_empty()):
			canMoveNegativeX = true

func _on_right_area_exited(body: Node2D) -> void:
	if (rObjects.has(body)):
		rObjects.erase(body)
		if (rObjects.is_empty()):
			canMovePositiveX = true

func _on_top_area_exited(body: Node2D) -> void:
	if (tObjects.has(body)):
		tObjects.erase(body)
		if (tObjects.is_empty()):
			canMoveNegativeY = true

func _on_bot_area_exited(body: Node2D) -> void:
	if (bObjects.has(body)):
		bObjects.erase(body)
		if (bObjects.is_empty()):
			canMovePositiveY = true
#endregion
