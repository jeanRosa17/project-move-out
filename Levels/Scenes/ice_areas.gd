extends Area2D

var player:Player

@export var soundPlayer:AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	# Make it so player always has the same velocity when on ice
	if (body.name == "Player"):
		player = body
		player.offControls()
		print(player.manager.direction)
		player.manager.changeState("Move")
		player.velocity = player.manager.direction

		soundPlayer.play()


func _on_body_exited(body: Node2D) -> void:
		if (body.name == "Player"):
			player.onControls()
			soundPlayer.stop()
