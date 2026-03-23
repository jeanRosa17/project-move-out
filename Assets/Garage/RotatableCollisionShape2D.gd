@tool
class_name RotatableCollisionShape2D
extends CollisionShape2D

## A container for alterative Collision shapes for this CollisionShape2D.
@export var shapes:Array[Shape2D] = []
@export var index:int = 0


func _process(delta: float) -> void:
	if (index > shapes.size()):
		index = shapes.size()
	
 
