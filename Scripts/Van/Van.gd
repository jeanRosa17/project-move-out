extends Area2D

var playerInArea:bool
@export var vanDoor:Area2D


func _process(delta:float)  -> void:
	if (Input.is_action_just_pressed("Lift") && playerInArea):
		print("pressed")
		clearVan()

func clearVan() -> void:
	# gets all furniture in van
	var bodies:Array[Node2D] = self.get_overlapping_bodies()
	#print(bodies.size())
	
	if (!vanDoor.has_overlapping_bodies()):
		print("door good")
		for i in range(bodies.size()):
			if bodies[i].is_in_group("Furniture"):
				bodies[i].queue_free()

func _on_button_area_area_entered(area: Area2D) -> void:
	print("in button")
	playerInArea = true


func _on_button_area_area_exited(area: Area2D) -> void:
	print("leave button")
	playerInArea = false
