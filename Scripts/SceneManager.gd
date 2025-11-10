extends ColorRect
class_name LevelManager

var tween = null
var duration:float = 1.0
@onready var level_manager: LevelManager = $"."

func _ready() -> void:
	level_manager.modulate.a = 1.0
	tween = null
	tween = get_tree().create_tween()
	#potentially add a delay here to make it transition a bit smoothly between tweens
	tween.tween_property(self, "modulate:a", 0.0, duration * 1.5).from(1.0)


func changeSceneTo(filePath:StringName) -> void:
	tween = null
	tween = get_tree().create_tween()
	tween.tween_property(self, "modulate:a", 1.0, duration).from(0.0)
	tween.tween_callback(get_tree().change_scene_to_file.bind(filePath))
