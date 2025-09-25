extends StateManager
class_name PlayerManager

@export var view:AnimatedSprite2D

var furniture:Furniture
var direction:Vector2
var hasEmptyDropZone:bool


func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.get_parent().is_in_group("Furniture")):
		self.furniture = area.get_parent()

func _on_area_2d_area_exited(_area: Area2D) -> void:
	self.furniture = null

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.is_in_group("Furniture") && self.furniture == null):
		self.furniture = body

func _on_area_2d_body_exited(body: Node2D) -> void:
	if (self.furniture == null): return
	if (self.getRootNode().find_child(self.furniture.name) != null): return
	self.furniture = null
