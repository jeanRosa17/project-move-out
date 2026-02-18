extends Node2D


@export var startPos:Vector2
var goTo:Vector2
var i:int = 0
@export var skipCutscene:bool = true

## A Dictionary with 
@export var events:Array[Vector2] = []
@onready var player: Player = $Player
#@onready var camera: Camera2D = $"../Y-Sorting/Player/Camera2D2"
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var y_sorting: Node2D = $".."

var tween:Tween

func _ready() -> void:
	#self.add_child(self.camera)
	self.position = self.startPos

func _process(_delta: float) -> void:
	var speed:float = 0.1 if (skipCutscene) else 3.0
	
	if (i != events.size()):
		if (tween == null):
			tween = create_tween()
			tween.tween_property(self, "position", self.events[0], speed).from(self.startPos)
			#tween.play()
		
		if (self.position == self.events[i]):
			if (i < events.size()): i += 1
			if (i == events.size()): 
				tween = null
				self.remove_child(self.player)
				self.y_sorting.add_child(self.player)
				
				self.player.view.play("jump down")
				self.player.position = Vector2(self.position.x, self.position.y+32)
				
				tween = create_tween()
				tween.tween_property(self.player, "position:y", self.position.y+56, 0.75).from(self.position.y)
				self.player.visible = true
				await get_tree().create_timer(0.5).timeout
				self.player.view.play("idle down")
				await get_tree().create_timer(0.3).timeout
				self.player.setControls(true)
				self.player.manager.getState().enable()
				return
			tween = null
			tween = create_tween()
			tween.tween_property(self, "position", self.events[i], speed).from(self.position)
			#tween.play()

	if (i == 1):
		self.sprite_2d.region_rect = Rect2(128, 0, 64, 48)
	
	if (i == 2):
		self.sprite_2d.region_rect = Rect2(0, 0, 64, 48)
