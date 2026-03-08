extends CanvasLayer

@onready var nextLevel: Button = $"Container/BoxContainer/Panel/Next Level"
@onready var replayLevel: Button = $Container/BoxContainer/Panel/Replay
@onready var exitLevel: Button = $Container/BoxContainer/Panel/Quit

@export var nextLevelName: StringName
@export var replayLevelName: StringName

@export var oneStarCompletion: float = 0.25
@export var twoStarCompletion: float = 0.50
@export var threeStarCompletion: float = 1

var transition_audio:AudioStreamPlayer2D


func _on_next_level_pressed() -> void:
	transition_audio = find_child("Level Transition Audio")
	if (nextLevelName != null):
		LevelManager.loadScene(nextLevelName)
		transition_audio.play()

func _on_replay_level_pressed() -> void:
	var current_scene := get_tree().current_scene
	transition_audio = find_child("Level Transition Audio")
	if current_scene:
		var path := current_scene.scene_file_path
		LevelManager.loadScene(path)
		transition_audio.play()

func _on_exit_game_pressed() -> void:
	#get_tree().quit()
	transition_audio = find_child("Level Transition Audio")
	LevelManager.loadScene("res://Scripts/UI/Scenes/TitleScreen.tscn")
	transition_audio.play()
