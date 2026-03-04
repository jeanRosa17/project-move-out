## A CanvasLayer used exclusively for displaying a Level Transition.
## Every LevelTransition must have an AnimationPlayer.
class_name LevelTransition
extends CanvasLayer


signal loading_screen_ready

@onready var animationPlayer:AnimationPlayer = $AnimationPlayer

## As soon as its created, it will play the animation and emit the loading_screen_ready when the
## animation finishes.
func _ready() -> void:
	await animationPlayer.animation_finished
	loading_screen_ready.emit()
	
## Signal function that is emited by the LevelManager while the new Level is being loaded. 
## newValue is a float 0.0-1.0
func _on_progress_changed(_newValue:float) -> void:
	pass # Leaving it blank for now

## Signal function that is emited by the LevelManger when the LevelManger finishes loading a Level.
## Then plays the animation in reverse. Once that animation is over, this node is destroyed.
func _on_load_finished() -> void:
	self.animationPlayer.play_backwards()
	await self.animationPlayer.animation_finished
	self.queue_free()
