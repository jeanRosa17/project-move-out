extends Area2D
var triggered:bool = false
@onready var textbox: DialogueManager = $"../CanvasLayer/Textbox"
@onready var canvas_layer: CanvasLayer = $"../CanvasLayer"
@export var tag: DialogueTag

func _ready() -> void:
	pass

func _on_body_entered(body) -> void:
	if (body.name == 'Player'):
		if !triggered:
			triggered = true
			self.textbox.setDialogueTo(self.tag)
	self.canvas_layer.visible = true
