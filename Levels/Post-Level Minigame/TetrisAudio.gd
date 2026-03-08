extends AudioStreamPlayer2D

class_name TetrisAudio

func landing() -> void:
	self.play()

func rotateSound() -> void:
	var player:AudioStreamPlayer2D = self.get_child(0)
	player.play()

func tick() -> void:
	var player:AudioStreamPlayer2D = self.get_child(1)
	player.play()
