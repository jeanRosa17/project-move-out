extends StateManager
class_name PlayerManager

@export var view:AnimatedSprite2D

var furniture:Furniture
var furniture2:FurniturePush
var direction:Vector2
var hasEmptyDropZone:bool


func _on_area_2d_area_entered(body: Node2D) -> void:
	#print("entered area2d")
	#print(body.get_parent().get_class())
	#print(body.get_parent().name)
	#print(body.get_parent().get_groups())
	if (body.get_parent().is_in_group("Furniture") &&
	 self.furniture2 == null):
		self.furniture2 = body.get_parent()

func _on_area_2d_area_exited(body: Node2D) -> void:
	#print("exited area2d")
	#print(body.get_parent().get_class())
	#print(body.get_parent().name)
	#print(body.get_parent().get_groups())
	if (self.furniture2 == null): 
		print("furniture is already null")
		return
	if (self.getRootNode().find_child(self.furniture2.name) != null): 
		print("didnt set furniture2")
		return
	self.furniture2 = null
	#print("should be ok")

#func _on_area_2d_body_entered(body: Node2D) -> void:
	#print("enter characterbody2d")
	#print(body.name)
	#if (body.is_in_group("Furniture") && self.furniture == null):
		#self.furniture = body
#
#func _on_area_2d_body_exited(body: Node2D) -> void:
	#print("exited characterbody2d")
	#print(body.name)
	#if (self.furniture == null): return
	#if (self.getRootNode().find_child(self.furniture.name) != null): return
	#self.furniture = null
