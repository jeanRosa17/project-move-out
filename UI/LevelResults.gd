extends CanvasLayer

@onready var nextLevel: Button = $"Container/BoxContainer/Panel/Next Level"
@onready var replayLevel: Button = $Container/BoxContainer/Panel/Replay
@onready var exitLevel: Button = $Container/BoxContainer/Panel/Quit
@onready var levelManager: LevelManager = $"../LevelManager"

@export var nextLevelName: StringName
@export var replayLevelName: StringName

@export var oneStarCompletion: float = 0.25
@export var twoStarCompletion: float = 0.50
@export var threeStarCompletion: float = 1


func _on_next_level_pressed() -> void:
	if (nextLevelName != null):
		self.levelManager.changeSceneTo(nextLevelName)

func _on_replay_level_pressed() -> void:
	var current_scene := get_tree().current_scene
	if current_scene:
		var path := current_scene.scene_file_path
		self.levelManager.changeSceneTo(path)

func _on_exit_game_pressed() -> void:
	#get_tree().quit()
	self.levelManager.changeSceneTo("res://UI/Scenes/TitleScreen.tscn")
