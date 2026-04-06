@tool
extends Node2D

@onready var hud: HUDManager = %HUD
@export var tag: DialogueTag

@export var doorType: Frame
@export var color_rect: ColorRect
@export var isLocked: bool = false
@export var inRange: bool = false
@export var isOpen: bool = false:
	set(value):
		if (value == true):
			self.hasBeenOpened = true
			area_2d.monitoring = false
			collisionShape.disabled = true
		isOpen = value
@export var hasBeenOpened: bool = false

@onready var shadow: Sprite2D = $Shadow
@onready var door_texture: AnimatedSprite2D = $DoorTexture
@onready var door_texture_2: AnimatedSprite2D = $DoorTexture2
@onready var frame: Sprite2D = $Frame
@onready var ap: AnimationPlayer = $AnimationPlayer
@onready var area_2d: Area2D = $Area2D
@onready var collisionShape: CollisionShape2D = $StaticBody2D/CollisionShape2D2

var tween:Tween

## Used to automatically set the Sprite for the Door. The first number
## represents the height in tiles and the second is the width
enum Frame {
	TWO_BY_ONE,
	TWO_BY_TWO,
	DOUBLE_DOOR
}


func _process(delta: float) -> void:
	if (Engine.is_editor_hint()):
		self.ap.play("debug")
	
	match doorType:
		Frame.TWO_BY_ONE:
			door_texture.position = Vector2(0, 0)
			door_texture.animation = "default"
			door_texture_2.visible = false
			frame.region_rect = Rect2(11, 8, 26, 34)
			shadow.region_rect = Rect2(16, 23, 16, 25)
		Frame.TWO_BY_TWO:
			door_texture.position = Vector2(0, -2)
			door_texture_2.visible = false
			door_texture.animation = "big"
			frame.region_rect = Rect2(119, 10, 34, 32)
			shadow.region_rect = Rect2(64, 23, 32, 25)
		Frame.DOUBLE_DOOR:
			door_texture.position = Vector2(-9, 0)
			door_texture_2.position = Vector2(9, 0)
			door_texture_2.visible = true
			door_texture.animation = "default"
			frame.region_rect = Rect2(59, 8, 42, 34)
			shadow.region_rect = Rect2(64, 23, 32, 25)
	
	if (self.inRange):
		if (Input.is_action_just_pressed("Interact")):
			self.hud.setDialogueTo(self.tag)
			self.isOpen = true
			self.ap.play("Fade")
			#await self.ap.animation_finished
			self.door_texture.play()
			
			if (self.doorType == Frame.DOUBLE_DOOR): self.door_texture_2.play()

func _on_player_detector_entered(area: Area2D) -> void:
	if (area.name == "Detector" and area.get_parent() is Player):
		var player:Player = area.get_parent()
		
		
		player.manager.item_detector.visible = true
		self.inRange = true

func _on_player_detector_exited(area: Area2D) -> void:
	if (area.name == "Detector" and area.get_parent() is Player):
		var player:Player = area.get_parent()
		
		player.manager.item_detector.visible = false
		self.inRange = false
		
