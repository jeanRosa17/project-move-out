extends AudioStreamPlayer2D


func _on_to_second_floor_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		var s:AudioStreamSynchronized = self.stream
		s.set_sync_stream_volume(1, -60)
		s.set_sync_stream_volume(0, -0)
		
	


func _on_to_first_floor_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		var s:AudioStreamSynchronized = self.stream
		s.set_sync_stream_volume(0, -60)
		s.set_sync_stream_volume(1, -0)
		
