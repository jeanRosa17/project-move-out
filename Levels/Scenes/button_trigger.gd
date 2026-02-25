extends Area2D
var playerIn:bool
@onready var hud:HUDManager = self.get_parent().get_parent().get_node("%HUD")

func _ready() -> void:
	playerIn = false

func _process(_delta:float)  -> void:
	# try to call the level manager to advance to tetris
	if (Input.is_action_just_pressed("Lift") && playerIn):
		print("pressed")
		hud.checkResults()

func _on_body_entered(body: Node2D) -> void:
	if (body is Player):
		print("gay")
		playerIn = true

func _on_body_exited(body: Node2D) -> void:
	if (body is Player):
		playerIn = false
