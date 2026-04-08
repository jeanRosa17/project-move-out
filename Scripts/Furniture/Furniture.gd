extends RigidBody2D

class_name Furniture

## Update to be $AudioStreamPlayer2D
@onready var audioPlayer: FurnitureAudio = %"Push_Pull Audio"
@onready var area_detector: Area2D = $AreaDetector
@onready var area_shape: CollisionShape2D = $AreaDetector/CollisionShape2D

const PACK_UP_BOX = preload("uid://k0rgciqs0uce")

@export var canLift:bool = false
@export var canPush:bool = false
@export var canPull:bool = false
@export var canRotate:bool
@export var rotatedVersion:Furniture
@export var tetroShape:Data.Tetronimo = Data.Tetronimo.one_by_one
var rotated: int = 0

@export var weight:int = 0
@export var dialogueTag:DialogueTag = preload("res://Scripts/Dialogue/nullDialogue.tres")
@export var liftPosition:Vector2 = Vector2(0, -16)

var isLifted: bool = false
var isPushed: bool = false
var canBeDropped: bool = true ## Changed to true so that a player can immediately pick up and drop something



@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var ghostSprite: Sprite2D

@onready var collider:CollisionShape2D = $Collision


var player: CharacterBody2D

var distanceFromPlayer:float
var anchorPoint:Vector2

var objects: Array[Node2D] = []

var tObjects: Array[Node2D] = []
var bObjects: Array[Node2D] = []
var rObjects: Array[Node2D] = []
var lObjects: Array[Node2D] = []

var ghostTween:Tween = null
var followTween:Tween = null
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
	self.freeze = true
	if (rotatedVersion != null):
		rotatedVersion.visible = false
		rotatedVersion.collision_layer = 0
		rotatedVersion.collision_mask = 0
		#rotatedVersion.rotatedVersion = self
		rotatedVersion.global_position = self.global_position
		
	
	if (self.collider.shape is RectangleShape2D):
		self.createAdditionalCollisions()
	elif (self.collider.shape is ConcavePolygonShape2D):
		self.create_additional_collisions_polygon()
	
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
	
	areaLeft.body_entered.connect(_on_left_area_entered)
	areaLeft.body_exited.connect(_on_left_area_exited)

func create_additional_collisions_polygon() -> void:
	var shape:ConcavePolygonShape2D = self.collider.shape
	var segs:Array[SegmentShape2D] = []
	for point in range(shape.segments.size()):
		var sh:CollisionShape2D = CollisionShape2D.new()
		sh.debug_color = Color.RED
		var area:Area2D = Area2D.new()
		var seg:SegmentShape2D = SegmentShape2D.new()
		
		
		seg.a = shape.segments.get(point)
		print(seg.a)
		# check for overflow
		if (point == shape.segments.size() - 1):
			seg.b = shape.segments.get(0)
			print(seg.b)
		else:
			seg.b = shape.segments.get(point + 1)
			
		sh.shape = seg
		
		area.collision_layer = 2
		area.collision_mask = 7
		
		# make segments a little smaller
		@warning_ignore("untyped_declaration")
		var sega = seg.a.lerp(seg.b, .05)
		
		@warning_ignore("untyped_declaration")
		var segb = seg.b.lerp(seg.a, .02)
			
		seg.a = sega
		seg.b = segb
		
		area.add_child(sh)
		self.add_child(area)
		
		segs.append(seg)
		
		# check to see if top bottom or side, connect signal and name
		var ray:RayCast2D = RayCast2D.new()
		if (abs(seg.a.y - seg.b.y) < 1):
			## this means its a horizontal edge meaning its either top or bottom
			#print("horrizontal")
			
			ray.position = Vector2((seg.a.x + seg.b.x) /2 , seg.a.y)
			self.collider.add_child(ray)
			ray.force_raycast_update()
			if (ray.get_collider()):
				#print("collided6")
				#print(ray.get_collider())
				if(ray.get_collider() == self):
					area.body_entered.connect(_on_bot_area_entered)
					area.body_exited.connect(_on_bot_area_exited)
					#print("bottom")
			else:
				area.body_entered.connect(_on_top_area_entered)
				area.body_exited.connect(_on_top_area_exited)
		else:
			print("vertical")
			ray.position = Vector2(seg.a.x, (seg.a.y + seg.b.y) / 2)

			self.collider.add_child(ray)
			ray.target_position = Vector2(-50, 0)
			ray.force_raycast_update()
			if (ray.get_collider()):
				if(ray.get_collider() == self):
					area.body_entered.connect(_on_right_area_entered)
					area.body_exited.connect(_on_right_area_exited)
					print("right")
			else:
				area.body_entered.connect(_on_left_area_entered)
				area.body_exited.connect(_on_left_area_exited)
	
		ray.queue_free()

func _physics_process(_delta: float) -> void:
	if (self.isLifted and self.ghostSprite != null):
		#print(self.ghostSprite.global_position)
		self.ghostSprite.self_modulate = (Color.GREEN if (self.canBeDropped) else Color.RED)
		#var offset:int = 32
		var offset:int = 1
		var pos:Vector2 = self.player.manager.detector.position
		
		self.ghostSprite.z_index = 0 if (self.player.manager.direction == Vector2.UP) else 10
		
		
		
		#print(self.player.manager.direction)
		if (self.followTween == null):
			self.followTween = get_tree().create_tween()
			self.followTween.tween_property(ghostSprite, "position", pos * offset , 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
		if (not self.followTween.is_running()):
			self.followTween.kill()
			self.followTween = create_tween()
			self.followTween.tween_property(ghostSprite, "position", pos * offset , 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	
	if (self.isPushed and self.player):
		if (self.player.get_real_velocity().length() < 1): linear_velocity = Vector2.ZERO
		
		if (self.position.distance_to(self.player.position) > self.distanceFromPlayer + 2):
			print("TOO FAR")
	
			player.global_position = player.global_position.move_toward(self.global_position, .9)
			#self.global_position = self.global_position.move_toward(player.global_position, 1)
			#self.global_position = self.global_position.move_toward(self.position + self.anchorPoint, 0.5)
#	
func update_detector_direction(direction: Vector2) -> void:
	if (abs(direction.x) > abs(direction.y)):
		if (direction.x > 0): area_detector.position = Vector2(liftPosition.y, 0)
		else: area_detector.position = liftPosition
		
	else:
		if (direction.y > 0): area_detector.position = Vector2(0, liftPosition.y)
		else: area_detector.position = liftPosition

## Ses the Ghost as a Sprite
func createGhostSprite(body:CharacterBody2D) -> void:
	assert(body is Player)
	var area:Area2D = Area2D.new()
	area.collision_layer = self.collision_layer
	area.collision_mask = self.collision_mask
	area.body_entered.connect(func () -> void: self.ghostSprite.self_modulate = Color.RED)
	area.body_exited.connect(func () -> void: self.ghostSprite.self_modulate = Color.GREEN)
	
	self.ghostSprite = sprite_2d.duplicate()
	
	#body.get_node("Detector").get_child(0).add_child(ghostSprite)
	#body.area2DCollision.add_child(self.ghostSprite)
	body.add_child(self.ghostSprite)
	self.ghostSprite.z_index = 10
	self.ghostSprite.position = Vector2(0, 0)
	self.ghostTween = self.get_tree().create_tween()
	self.ghostTween.tween_property(ghostSprite, "self_modulate:a", 0, 1.0).set_delay(0.2)
	self.ghostTween.tween_property(ghostSprite, "self_modulate:a", 1.0, 1.0).set_delay(0.2)
	#self.ghostTween.set_
	self.ghostTween.set_loops()
	#self.followTween.set_loops()


#region Tweens  Animation
# Starts the hovering tween animation
func startLiftingTween() -> void:
	var tween: Tween = create_tween()
	self.floatXTween = get_tree().create_tween()
	self.floatYTween = get_tree().create_tween()
	# self.floatTiltTween = get_tree().create_tween()
	
	tween.tween_property(self, "scale", Vector2(0.3, 0.3), 0.4)
	
	self.floatXTween.tween_property(self, "position:x", -8, 0.4).set_delay(0.05)
	self.floatXTween.tween_property(self, "position:x", 8, 0.3).set_delay(0.05)
	self.floatXTween.set_loops().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	
	self.floatYTween.tween_property(self, "position:y", self.liftPosition.y -8, 0.2).set_delay(0.05)
	self.floatYTween.tween_property(self, "position:y", self.liftPosition.y + 4, 0.3).set_delay(0.05)
	self.floatYTween.set_loops().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)
	
	#self.floatTiltTween.tween_property(self, "rotation_degrees", -4, 0.5).set_delay(0.4)
	#self.floatTiltTween.tween_property(self, "rotation_degrees", 4, 0.5).set_delay(0.8)
	#self.floatTiltTween.set_loops().set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_ELASTIC)

# Stops all lifting tweens
func killLiftingTween() -> void:
	if (self.floatXTween):
		self.floatXTween.kill()
	
	if (self.floatYTween):
		self.floatYTween.kill()
	
	if (self.floatTiltTween):
		self.floatTiltTween.kill()
		
	if (self.ghostTween):
		self.ghostTween.kill()
	
	#self.floatXTween = null
	#self.floatYTween = null
	#self.floatTiltTween = null
	
	self.rotation_degrees = 0

#endregion

#region Lift / Pushing

func enterLift(body:CharacterBody2D) -> void:
	print("enterLift")
	self.remove_from_group("Furniture")
	self.collision_layer = 1;
	self.collision_mask = 6;
	self.reparent(body)
	self.position = self.liftPosition
	self.isLifted = true
	self.startLiftingTween()
	self.get_node("Collision").disabled = true
	self.player = self.get_parent()
	self.createGhostSprite(body)

	audioPlayer.pick_up_noise()
	

func exitLift() -> void:
	#print("ghost global pos = ", ghostSprite.global_position)
	print("exitLift for Furniture")
	self.killLiftingTween()
	
	self.get_node("Collision").disabled = false
	self.position = self.player.manager.detector.global_position
	self.ghostSprite.queue_free()
	self.collision_layer = 2;
	self.collision_mask = 7;
	self.isLifted = false
	
	self.player = null
	self.scale = Vector2(1, 1)
	self.add_to_group("Furniture")
	audioPlayer.put_down_noise()

func enterPush(body: CharacterBody2D) -> void:
	print("entered pushing")
	self.player = body
	print(player.name)
	self.collision_layer = 1
	self.collision_mask = 6
	audioPlayer.push_sound(self)
	self.distanceFromPlayer = position.distance_to(player.position)
	self.anchorPoint = player.position - self.position
	self.isPushed = true
	self.freeze = false

func exitPush()-> void:
	print("exited pushing")
	self.player.manager.item_detector.visible = false
	self.player.manager.furniture = null
	self.player = null
	self.collision_layer = 2
	self.collision_mask = 7
	self.isPushed = false
	self.freeze = true
	self.linear_velocity = Vector2.ZERO
	
#endregion

# If has a rotated object and rotated version can fit, rotate.
func rotateObj() -> void:
	if (self.rotatedVersion):
		if (tryRotate()):
			print("rotate")
			print("rotating: ", self.name)
			@warning_ignore("untyped_declaration") var pos = self.global_position
			
			self.exitPush()
			self.visible = false
			self.collision_layer = 0
			self.collision_mask = 0
			
			rotatedVersion.global_position = pos
			rotatedVersion.reparent(self.get_parent())
			
			#rotatedVersion.canRotate = true
			rotatedVersion.rotatedVersion = self
			rotatedVersion.dialogueTag = self.dialogueTag
			
			self.reparent(rotatedVersion)
			rotatedVersion.visible = true
			rotatedVersion.collision_layer = 2
			rotatedVersion.collision_mask = 7
			
			player.manager.furniture = rotatedVersion
			
			audioPlayer.rotate_noise()
			
			rotatedVersion.enterPush(player)
		else:
			print("cant")

#Shapecasts the rotated versions collision shape to see if it will collide with anything.
func tryRotate() -> bool:
	var cast:ShapeCast2D = ShapeCast2D.new()
	cast.add_exception(player)
	var shape:CollisionShape2D = CollisionShape2D.new()
	shape.shape = rotatedVersion.collider.shape
	shape.debug_color = Color.RED
	cast.shape = shape.shape
	cast.collision_mask = 7
	self.add_child(cast)


	
	cast.target_position = Vector2(0,0)
	cast.force_shapecast_update()
	
	if (cast.is_colliding()):
		print("overlapping bodies")
		cast.queue_free()
		audioPlayer.cant_rotate_noise()
		return false
	else:
		print("no overlap")
		cast.queue_free()
		return true

#region Signals
func againstObject(newObject: Node2D) -> void:
	objects.append(newObject)
	print("added object: ", newObject.name)
	

func relieveObject(newObject: Node2D) -> void:
	if (objects.has(newObject)):
		objects.erase(newObject)
		print("removed object: ")
		print(newObject.name)            
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

## Returns this Furniture's Tetronimo shape
func getShape() -> Data.Tetronimo:
	# gives the tetro shape of the furniture
	return tetroShape

## Plays the pack up animation when the Furniture is in the loading zone. 
## This Furniture will be destroyed afterwards.
func packInBox() -> void:
	print("pack in")

	var child = PACK_UP_BOX.instantiate()
	var t:Tween
	
	
	self.add_sibling(child)
	
	t = create_tween()
	#child.marker_2d.add_child(self)
	await get_tree().process_frame
	self.collision_mask = -1
	self.collision_layer = -1
	child.ap.play("Open")
	child.position = self.position
	#self.reparent(child.marker_2d)
	
	#t.set_parallel(false)
	t.tween_property(self, "position:y", -8, 0.2).from(0).set_delay(0.33)
	#t.tween_property(self, "position:y", 8, 0.2).from(0).set_delay(0.33)
	t.parallel()
	t.tween_property(self, "scale", Vector2(0, 0), 0.2).from(Vector2(1, 1)).set_delay(0.33)
	t.tween_callback(func () -> void:
		self.queue_free()).set_delay(0.3)
	
	#child.marker_2d.reparent(self)
