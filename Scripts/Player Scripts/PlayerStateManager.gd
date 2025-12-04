extends StateManager
class_name PlayerManager

@export var view:AnimatedSprite2D

var furniture:Furniture
var direction:Vector2
var hasEmptyDropZone:bool


func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.get_parent().is_in_group("Furniture")):
		if (furniture && !self.furniture.isPushed && !self.furniture.isLifted):
			print(furniture.name)
			self.furniture = area.get_parent()
		elif (furniture == null):
			self.furniture = area.get_parent()

func _on_area_2d_area_exited(area: Area2D) -> void:
	if (area.get_parent().is_in_group("Furniture")):
		if (self.furniture == null): return
		if (!self.furniture.isLifted && !self.furniture.isPushed):
			self.furniture = null

func _on_furniture_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Furniture") && self.furniture == null):
		self.furniture = body as Furniture

func _on_furniture_body_exited(body: Node2D) -> void:
	if (self.furniture == null): return
	elif (body.is_in_group("Furniture") && self.furniture != null && !self.furniture.isLifted && !self.furniture.isPushed):
		self.furniture = null
	#if (self.getRootNode().find_child(self.furniture.name) != null): return
