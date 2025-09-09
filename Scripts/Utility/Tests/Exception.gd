## A simple error handling class that outputs a given error message and stops the game when
## created. This allows us to catch bugs and avoid having to disable assert statements across
## scripts.
class_name Exception

func _init(message:String="") -> void:
	printerr(message)
	assert(false, message)
