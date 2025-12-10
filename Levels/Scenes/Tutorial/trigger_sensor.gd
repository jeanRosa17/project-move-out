extends Area2D
var triggered:bool = false
@onready var hud: HUDManager = self.get_parent().get_parent().get_node("%HUD")
@export var tag: DialogueTag

func _ready() -> void:
	pass

func _on_body_entered(body) -> void:
	if (body.name == 'Player'):
		if !triggered:
			triggered = true
			self.hud.setDialogueTo(self.tag)
