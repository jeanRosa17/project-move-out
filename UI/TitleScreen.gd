extends Node2D

@onready var play: Button = $Play
@onready var levelManager: LevelManager = $LevelManager
@onready var title: RichTextLabel = $Title
@onready var creators: RichTextLabel = $Creators
@onready var bg: Node2D = $BG
@onready var moving_van: Node2D = $"Moving Van"

#@onready var floor2: TileMapLayer = $Floor2

var bgSpeed: float = 8.0

func _ready() -> void:
	self.startTweens()
	self.loopBackground()

func _process(_delta) -> void:
	if (bg.position.x < -912):
		$BG/Floor.position.x += (912*2)
	
	if (bg.position.x < -912*2):
		$BG/Floor2.position.x += (912*2)
		self.bg.position.x = 0

func _on_play_pressed() -> void:
	self.levelManager.z_index = 1
	self.levelManager.changeSceneTo("res://Levels/Scenes/Tutorial/OpenFloorTutorial.tscn")

func startTweens():
	var authors = create_tween()
	#var titleText = create_tween()
	var playButton = create_tween()
	var van = create_tween()
	
	moving_van.position.x = -300
	creators.modulate.a = 0.0
	title.modulate.a = 0.0
	play.modulate.a = 0.0
	
	authors.tween_property(creators, "modulate:a", 1.0, 0.5).from(0)
	#authors.tween_property(creators, "modulate:a", 0.0, 0.25).set_delay(1.5)
	
	van.tween_property(moving_van, "position:x", 160, 2.0).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE)

	van.set_loops()
	van.tween_property(moving_van, "position:x", 180, 4.0).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE)
	van.tween_property(moving_van, "position:x", 130, 3.0).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE).set_delay(3)


	#titleText.tween_property(title, "position:y", 8, 2.0).from(-300).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE)
	playButton.tween_property(play, "position:y", 171, 2.0).from(300).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_BOUNCE)
	
	title.modulate.a = 1.0
	play.modulate.a = 1.0
	
func loopBackground() -> void:
	var floorT1 = create_tween()
	
	
	floorT1.tween_property(bg, "position:x", -912.0, bgSpeed).from(0)
	floorT1.set_loops()
	#floorT2.tween_property(floor2, "position:x", -336.0, bgSpeed * 2).from(320)
	#floorT2.set_loops()
