@tool
class_name RotatableCollisionShape2D
extends CollisionShape2D

## A container for alterative Collision shapes for this CollisionShape2D.
@export var left:Shape2D
@export var right:Shape2D
@export var up:Shape2D
@export var down:Shape2D



func _process(delta: float) -> void:
	pass
 
