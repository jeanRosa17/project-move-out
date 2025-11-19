extends Area2D

var player:Player

@export var soundPlayer:AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		player = body
		player.offControls()
		soundPlayer.play()


func _on_body_exited(body: Node2D) -> void:
		if (body.name == "Player"):
			player.onControls()
			soundPlayer.stop()
