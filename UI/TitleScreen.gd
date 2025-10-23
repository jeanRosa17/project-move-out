extends Node2D

@onready var play_tutorial_a: Button = $"Container/BoxContainer/Panel/Play Tutorial A"
@onready var play_tutorial_b: Button = $"Container/BoxContainer/Panel/Play Tutorial B"
@onready var settings: Button = $Container/BoxContainer/Panel/Settings
@onready var fader: ColorRect = $Fader


var tween:Tween = null


func _on_play_tutorial_a_pressed() -> void:
	self.changeSceneTo("res://Levels/Scenes/Tutorial/OpenFloorTutorial.tscn")


func _on_play_tutorial_b_pressed() -> void:
	self.changeSceneTo("res://Levels/Scenes/Tutorial/Tutorial_Lobby.tscn")

func changeSceneTo(filePath:StringName) -> void:
	tween = null
	tween = get_tree().create_tween()
	tween.tween_property(fader, "modulate:a", Color.BLACK.a, 1.0).from(0.0)
	tween.tween_callback(get_tree().change_scene_to_file.bind(filePath))
