extends Area2D

var player:Player

var velocityCheck:bool = false

@export var soundPlayer:AudioStreamPlayer2D

func _process(float) -> void:
	if (velocityCheck):
		if (player.get_real_velocity().length() < .2 && !player.canControl):
			player.setControls(true)
		elif (player.canControl):
			player.setControls(false)


func _on_body_entered(body: Node2D) -> void:
	# Make it so player always has the same velocity when on ice
	if (body.name == "Player"):
		player = body
		if (player.canControl):
			player.setControls(false)
			player.manager.changeState("Move")
			
			if (player.velocity.length() < .2):
				player.velocity = player.manager.direction
			else:
				print("stuck case")
				player.velocity = player.manager.direction * 5
			soundPlayer.play()
		
			velocityCheck = true
			
			


func _on_body_exited(body: Node2D) -> void:
		if (body.name == "Player"):
			player.setControls(true)
			soundPlayer.stop()
			
			velocityCheck = false
