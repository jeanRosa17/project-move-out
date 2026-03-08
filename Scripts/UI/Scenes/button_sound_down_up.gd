extends AudioStreamPlayer2D


func _on_play_button_down() -> void:
	print("PLAY")
	self.play()


func _on_play_button_up() -> void:
	var player:AudioStreamPlayer2D = self.get_child(0)
	player.play()
