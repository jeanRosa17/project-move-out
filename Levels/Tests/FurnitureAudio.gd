extends AudioStreamPlayer2D

class_name FurnitureAudio

@export var streams:Array = [];


func _ready() -> void:
	pass

func push_sound(furniture:Furniture) -> void:
		#if(furniture.linear_velocity.length() > 1):
			#play(0.3)
		await get_tree().create_timer(.05).timeout
		stop()
		
		if (not furniture): return
		
		if (furniture.isPushed):
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
	
func rotate_noise() -> void:
	var player:AudioStreamPlayer2D = self.get_child(2)
	player.play()

func cant_rotate_noise() -> void:
	var player:AudioStreamPlayer2D = self.get_child(3)
	player.play()
	
func dialogue() -> void:
	var player:AudioStreamPlayer2D = self.get_child(4)
	player.play()
