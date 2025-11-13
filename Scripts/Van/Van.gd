extends Area2D

@onready var hud:HUDManager = self.get_parent().get_parent().get_parent().get_node("%HUD")

var playerInArea:bool
@export var vanDoor:Area2D
@export var furniture:Array[Node]

@export var score:float

func _ready() -> void:
	furniture = get_tree().get_nodes_in_group("Furniture")
	
	
func _process(_delta:float)  -> void:
	if (Input.is_action_just_pressed("Lift") && playerInArea):
		print("pressed")
		clearVan()
		#display the score with the HUD

func clearVan() -> void:
	# gets all furniture in van
	var bodies:Array[Node2D] = self.get_overlapping_bodies()
	var furnitureInVan = bodies.size()
	#print(bodies.size())
	
	var totalFurniture:int = furniture.size()
	
	if (!vanDoor.has_overlapping_bodies()):
		print("door good")
		for i in range(bodies.size()):
			if bodies[i].is_in_group("Furniture"):
				bodies[i].queue_free()
				score = furnitureInVan / float(totalFurniture) 
				print(score)
				hud.checkResults(score)
	else:
		print("Van is empty")

func _on_button_area_area_entered(_area: Area2D) -> void:
	print("in button")
	playerInArea = true


func _on_button_area_area_exited(_area: Area2D) -> void:
	print("leave button")
	playerInArea = false
