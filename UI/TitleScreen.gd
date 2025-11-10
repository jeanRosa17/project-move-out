extends Node2D

@onready var play_tutorial_a: Button = $"Container/BoxContainer/Panel/Play Tutorial A"
@onready var settings: Button = $Container/BoxContainer/Panel/Settings
@onready var levelManager: LevelManager = $LevelManager


func _on_play_tutorial_a_pressed() -> void:
	self.levelManager.changeSceneTo("res://Levels/Scenes/Tutorial/OpenFloorTutorial.tscn")


func _on_play_tutorial_b_pressed() -> void:
	self.levelManager.changeSceneTo("res://Levels/Level Templates/LevelTemplate.tscn")
