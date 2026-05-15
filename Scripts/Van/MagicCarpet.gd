extends Area2D

@onready var hud:HUDManager = self.get_parent().get_parent().get_node("%HUD")

var playerInArea:bool
var player:Player
@export var vanDoor:Area2D
@export var furniture:Array[Node]

func _ready() -> void:
	playerInArea = false;

func _process(_delta:float)  -> void:
	if (playerInArea && Input.is_action_just_pressed("Interact")):
		await(get_tree().create_timer(0.5).timeout)
		hud.runTetris()
	

func clearVan() -> void:
	if (!hud.levelFinished):
		# gets all furniture in van
		var bodies:Array[Node2D] = self.get_overlapping_bodies()
		
		for body in bodies:
			if body.is_in_group("Furniture"):
				Data.previousItemList.append(body.duplicate())
				hud.addPackedFurniture(body.getShape())
				body.packInBox()
				#bodies[i].queue_free()
		
		# hud.runTetris()

# tracks if the player is on the carpet.
func _on_body_entered(body: Node2D) -> void:
	if (body is Player):
		playerInArea = true;
		player = body

func _on_body_exited(body: Node2D) -> void:
	if (body is Player):
		playerInArea = false
		clearVan()
