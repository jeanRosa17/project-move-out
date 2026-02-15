extends Node2D


@export var startPos:Vector2
var goTo:Vector2
var i:int = 0

## A Dictionary with 
@export var events:Array[Vector2] = []
@onready var player: Player = $"../Y-Sorting/Player"
@onready var camera: Camera2D = $"../Y-Sorting/Player/Camera2D2"


func _ready() -> void:
	self.add_child(self.camera)
	self.position = self.events[0]


func _process(delta: float) -> void:
	if (self.position != self.events[i]):
		self.position.x -= move_toward(self.position.x, self.events[i].x, 0.25)
		self.position.y -= move_toward(self.position.y, self.events[i].y, 0.25)
	else:
		if (i != events.size()):
			i += 1


class Event:
	pass
