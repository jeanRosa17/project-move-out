extends Area2D

@onready var hud:HUDManager = self.get_parent().get_parent().get_node("%HUD")

var playerInArea:bool
var player:Player
@export var vanDoor:Area2D
@export var furniture:Array[Node]

func _ready() -> void:
	playerInArea = false;

func _process(_delta:float)  -> void:
	pass

func clearVan() -> void:
	if (!hud.levelFinished):
		# gets all furniture in van
		var bodies:Array[Node2D] = self.get_overlapping_bodies()
		
		for i in range(bodies.size()):
			if bodies[i].is_in_group("Furniture"):
				hud.addPackedFurniture(bodies[i].getShape())
				bodies[i].queue_free()
		
		hud.runTetris()

# tracks if the player is in the truck
func _on_body_entered(body: Node2D) -> void:
	if (body is Player):
		playerInArea = true;
		player = body

func _on_body_exited(body: Node2D) -> void:
	if (body is Player):
		playerInArea = false
		body = null
		clearVan()
