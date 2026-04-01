class_name Teleporter
extends Area2D

@export var goTo:Teleporter
@onready var collision:CollisionShape2D = $CollisionShape2D


func _on_teleported(body: Node2D) -> void:
	print("Teleporting to")
	
	self.goTo.collision.call_deferred("set_disabled", true)
	body.call_deferred("set_position", self.goTo.position)
	
	await get_tree().create_timer(2).timeout
	
	self.goTo.collision.call_deferred("set_disabled", false)
	

	
