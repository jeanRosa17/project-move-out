class_name Teleporter
extends Area2D

@export var goTo:Teleporter
@export var furniturePos:Vector2
@onready var collision:CollisionShape2D = $CollisionShape2D



func _on_teleported(body: Node2D, tele:bool = false) -> void:
	print("Teleporting to")
	
	if (body is Player):
		self.goTo.collision.call_deferred("set_disabled", true)
		body.manager.call_deferred("changeState", "Idle")
		body.call_deferred("set_position", self.goTo.position)
		
		if (body.manager.hasFurniture):
			if (body.manager.furniture.isPushed):
				body.manager.furniture.call_deferred("exitPush")
				body.manager.furniture.call_deferred("set_position", self.goTo.position + self.goTo.furniturePos)
			#body.manager.furniture.call_deferred("exitLift")
			
	
		await get_tree().create_timer(3).timeout
	
		self.goTo.collision.call_deferred("set_disabled", false)
