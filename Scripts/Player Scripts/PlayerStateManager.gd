## The Model for the Player. Variables and Signals used across all the States
## are kept here.
extends StateManager
class_name PlayerManager

@export var view:AnimatedSprite2D

var furniture:Furniture
var direction:Vector2
var hasEmptyDropZone:bool

var hasFurniture:bool

var isSliding:bool = false

func _on_furniture_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Furniture") && (not self.hasFurniture)):
		self.furniture = body as Furniture
		self.hasFurniture = true

func _on_furniture_body_exited(body: Node2D) -> void:
	if (not self.hasFurniture): return
	elif (body.is_in_group("Furniture") && self.furniture != null && !self.furniture.isLifted && !self.furniture.isPushed):
		self.furniture = null
		self.hasFurniture = false
