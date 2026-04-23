class_name Teleporter
extends Area2D

@export var goTo:Teleporter
@export var furniturePos:Vector2
@onready var collision:CollisionShape2D = $CollisionShape2D
var dictionary:Dictionary[Node2D, bool]



func _on_teleported(body: Node2D, tele:bool = false) -> void:
	print("Teleporting to")
	
	self.goTo.collision.call_deferred("set_disabled", true)
	if (body is Furniture):
		await get_tree().create_timer(0.75).timeout
		if (tele): 
			body.collider.disabled = true
			return
			#self._on_teleported(body, true)
		if (tele == false):
			body.collider.disabled = false
			self._on_teleported(body, true)
			await get_tree().create_timer(0.75).timeout
			
		body.call_deferred("exitPush")
		body.call_deferred("exitLift")
		body.call_deferred("set_position", self.goTo.position + self.goTo.furniturePos)
	else:
		body.manager.call_deferred("changeState", "Idle")
		body.call_deferred("set_position", self.goTo.position)
	
	await get_tree().create_timer(3).timeout
	
	self.goTo.collision.call_deferred("set_disabled", false)
	

	
