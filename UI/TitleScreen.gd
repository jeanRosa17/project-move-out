extends Node2D

@onready var play: Button = $Play
@onready var levelManager: LevelManager = $LevelManager
@onready var title: RichTextLabel = $Title
@onready var creators: RichTextLabel = $Creators

func _ready() -> void:
	self.startTweens()

func _on_play_pressed() -> void:
	self.levelManager.z_index = 1
	self.levelManager.changeSceneTo("res://Levels/Scenes/Tutorial/OpenFloorTutorial.tscn")

func startTweens():
	var authors = create_tween()
	var titleText = create_tween()
	var playButton = create_tween()
	
	creators.modulate.a = 0.0
	title.modulate.a = 0.0
	play.modulate.a = 0.0
	
	authors.tween_property(creators, "modulate:a", 1.0, 0.5).from(0)
	authors.tween_property(creators, "modulate:a", 0.0, 0.25).set_delay(1.5)
	
	titleText.tween_property(title, "position:y", 8, 2.0).from(-300).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE)
	playButton.tween_property(play, "position:y", 160, 2.0).from(300).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE)
	
	title.modulate.a = 1.0
	play.modulate.a = 1.0
	
