class_name Teleporter
extends Area2D

@export var goTo:Teleporter
@export var furniturePos:Vector2
@onready var collision:CollisionShape2D = $CollisionShape2D


func _on_teleported(body: Node2D) -> void:
	print("Teleporting to")
	
	self.goTo.collision.call_deferred("set_disabled", true)
	if (body is Furniture):
		body.call_deferred("exitPush")
		body.call_deferred("set_position", self.goTo.position + self.goTo.furniturePos)
	else:
		body.manager.call_deferred("changeState", "Idle")
		body.call_deferred("set_position", self.goTo.position)
	
	await get_tree().create_timer(2).timeout
	
	self.goTo.collision.call_deferred("set_disabled", false)
	

	
