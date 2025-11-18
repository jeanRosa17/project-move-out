extends AudioStreamPlayer2D

class_name FurnitureAudio

@export var streams:Array = [];


func _ready() -> void:
	pass

func push_sound(furniture:Furniture) -> void:
		if(furniture.linear_velocity.length() > 1):
			play(0.3)
		await get_tree().create_timer(.05).timeout
		stop()
		if (furniture.isPushing):
			push_sound(furniture)
		## recursively play different pieces of audio at different pitches

func stop_sound() -> void:
	stop()
	
func put_down_noise() -> void:
	var player:AudioStreamPlayer2D = self.get_child(0)
	player.play()
	
func pick_up_noise() -> void:
	var player:AudioStreamPlayer2D = self.get_child(1)
	player.play()
