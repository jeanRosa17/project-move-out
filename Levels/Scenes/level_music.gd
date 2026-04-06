extends AudioStreamPlayer2D



func _on_finished() -> void:
	var body:AudioStreamPlayer2D = self.get_child(0)
	body.play()
