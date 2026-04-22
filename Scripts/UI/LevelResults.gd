extends CanvasLayer

@onready var nextLevel: Button = $"Container/BoxContainer/Panel/Next Level"
@onready var replayLevel: Button = $Container/BoxContainer/Panel/Replay
@onready var exitLevel: Button = $Container/BoxContainer/Panel/Quit

@export var oneStarCompletion: float = 0.25
@export var twoStarCompletion: float = 0.50
@export var threeStarCompletion: float = 1

var transition_audio:AudioStreamPlayer2D


func _on_next_level_pressed() -> void:
	transition_audio = find_child("Level Transition Audio")
	Data.levelNum += 1
	LevelManager.loadScene(Data.Levels[Data.levelNum])
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

func save_hub() -> void:
	var scene = PackedScene.new()
	var node = self.get_parent().get_parent()
	var result = scene.pack(node)
	if result == OK:
		print("saved")
		var error = ResourceSaver.save(scene, "res://Levels/Scenes/SAVED_HUBS/BURGER.tscn")
		var path = "res://Levels/Scenes/SAVED_HUBS/BURGER.tscn"
		ResourceUID.add_id(ResourceUID.create_id(), path)
		var uid = ResourceLoader.get_resource_uid(path)
		#print(ResourceUID.id_to_text(uid))
		Data.newHub = ResourceUID.id_to_text(uid)
		if error != OK:
			push_error("An error occurred while saving the scene to disk.")
	
