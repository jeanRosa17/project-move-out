extends CanvasLayer

@onready var nextLevel: Button = $"Container/BoxContainer/Panel/Next Level"
@onready var replayLevel: Button = $Container/BoxContainer/Panel/Replay
@onready var exitLevel: Button = $Container/BoxContainer/Panel/Quit

@export var nextLevelName: StringName
@export var replayLevelName: StringName

@export var oneStarCompletion: float = 0.25
@export var twoStarCompletion: float = 0.50
@export var threeStarCompletion: float = 1


func _on_next_level_pressed() -> void:
	if (nextLevelName != null):
		LevelManager.loadScene(nextLevelName)

func _on_replay_level_pressed() -> void:
	var current_scene := get_tree().current_scene
	if current_scene:
		var path := current_scene.scene_file_path
		LevelManager.loadScene(path)

func _on_exit_game_pressed() -> void:
	#get_tree().quit()
	LevelManager.loadScene("res://Scripts/UI/Scenes/TitleScreen.tscn")
