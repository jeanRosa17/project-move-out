## The Model for the Player. Variables and Signals used across all the States
## are kept here.
extends StateManager
class_name PlayerManager

## The Player's animated sprite 2D. Used so that the states can set animations.
@export var view:AnimatedSprite2D

## Holds a reference to the furniture the player is looking at. When no Furniture is referenced,
## this value should be nulled. This variable has a custom set function that makes hasFurniture
## true when furniture is assigned to a value, and false when furniture becomes null.
var furniture:Furniture:
	set(value):
		furniture = value
		hasFurniture = (value != null)
		
var direction:Vector2
var hasEmptyDropZone:bool

var hasFurniture:bool
@onready var item_detector: Sprite2D = $"../ItemDetector"

var isSliding:bool = false

func _on_furniture_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Furniture") && (not self.hasFurniture)):
		self.furniture = body as Furniture
		if not (self.furniture.canLift == false && self.furniture.canPush == false && self.furniture.canPull == false):
			self.item_detector.visible = true
		

func _on_furniture_body_exited(body: Node2D) -> void:
	if (not self.hasFurniture): return
	elif (body.is_in_group("Furniture") && self.furniture != null && !self.furniture.isLifted && !self.furniture.isPushed):
		self.furniture = null
		self.item_detector.visible = false
		
