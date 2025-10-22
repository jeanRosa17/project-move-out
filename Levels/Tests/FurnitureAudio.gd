extends AudioStreamPlayer2D

class_name FurnitureAudio

@export var streams = [];

func push_sound(furniture:Furniture) -> void:
		print("sound")
		# does not work yet
		streams[0].play
	
