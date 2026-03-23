class_name LeaveArea
extends Area2D
var playerIn:bool

signal end_level


func _ready() -> void:
	playerIn = false

func _process(_delta:float)  -> void:
	# try to call the level manager to advance to tetris
	if (Input.is_action_just_pressed("Lift") && playerIn):
		print("pressed")
		
		
		await get_tree().create_timer(1.5).timeout
		end_level.emit() ## Triggers the _on_end function in the StorageVan 

func _on_body_entered(body: Node2D) -> void:
	print(body.name)
	if (body.name == "Detector"):
		print("yayy")
		body.manager.item_detector.visible = true
		playerIn = true
		
	if (body is Player):
		body.manager.item_detector.visible = true
		
		print("gay")
		playerIn = true

func _on_body_exited(body: Node2D) -> void:
	if (body is Player):
		playerIn = false
		
		body.manager.item_detector.visible = false
