## The Model for the Player. Variables and Signals used across all the States
## are kept here.
extends StateManager
class_name PlayerManager

@export var view:AnimatedSprite2D

var furniture:Furniture
var direction:Vector2
var hasEmptyDropZone:bool

var hasFurniture:bool

func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.get_parent().is_in_group("Furniture")):
		if (self.hasFurniture && !self.furniture.isPushed && !self.furniture.isLifted):
			print(furniture.name)
			self.furniture = area.get_parent()
		elif (not self.hasFurniture):
			self.furniture = area.get_parent()
		self.hasFurniture = true

func _on_area_2d_area_exited(area: Area2D) -> void:
	if (area.get_parent().is_in_group("Furniture")):
		if (not self.hasFurniture): return
		if (!self.furniture.isLifted && !self.furniture.isPushed):
			self.furniture = null
			self.hasFurniture = false

func _on_furniture_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Furniture") && (not self.hasFurniture)):
		self.furniture = body as Furniture
		self.hasFurniture = true

func _on_furniture_body_exited(body: Node2D) -> void:
	if (not self.hasFurniture): return
	elif (body.is_in_group("Furniture") && self.furniture != null && !self.furniture.isLifted && !self.furniture.isPushed):
		self.furniture = null
		self.hasFurniture = false
