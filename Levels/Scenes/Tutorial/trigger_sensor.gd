extends Area2D
@export var triggered:bool = false
@onready var hud: HUDManager = %HUD
@export var tag: DialogueTag

func _ready() -> void:
	pass

@warning_ignore("untyped_declaration")
func _on_body_entered(body) -> void:
	if (body.name == 'Player'):
		if !triggered:
			triggered = true
			self.hud.setDialogueTo(self.tag)
