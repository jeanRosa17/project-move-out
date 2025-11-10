extends CanvasLayer

@onready var nextLevel: Button = $"Result Screen/Next Level"
@onready var replayLevel: Button = $"Result Screen/Replay Level"
@onready var exitLevel: Button = $"Result Screen/Exit Game"
@onready var levelManager: LevelManager = $LevelManager

@export var nextLevelName: StringName
@export var replayLevelName: StringName

@export var oneStarCompletion: float = 0.25
@export var twoStarCompletion: float = 0.50
@export var threeStarCompletion: float = 1



func _on_next_level_pressed() -> void:
	if (nextLevelName != null):
		self.levelManager.changeSceneTo(nextLevelName)


func _on_replay_level_pressed() -> void:
	if (replayLevelName != null):
		self.levelManager.changeSceneTo(replayLevelName)

func _on_exit_game_pressed() -> void:
	get_tree().quit()
