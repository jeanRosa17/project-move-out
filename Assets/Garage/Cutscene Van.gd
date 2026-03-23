@tool
class_name CutsceneVan
extends StaticBody2D

@export var hasJohn:bool
@export var keyIn:bool ## Determines if the Car should be playing its animation
@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var smoke: Node2D = $Smoke
@export var smokeMarkers:Array[Marker2D] = []


@export var direction:Data.Direction = Data.Direction.DOWN


func _process(delta: float) -> void:
	var animationName:String = "-no-john" if not hasJohn else ""
	
	match (self.direction):
		Data.Direction.UP:
			animationName = "up"
			smoke.position = smokeMarkers[0].position
			smoke.rotation_degrees = 270
			smoke.z_index = 1
		Data.Direction.LEFT:
			animationName = "left" + animationName
			smoke.position = smokeMarkers[1].position
			smoke.rotation_degrees = 180
			smoke.z_index = 0
		Data.Direction.RIGHT:
			animationName = "right" + animationName
			smoke.position = smokeMarkers[2].position
			smoke.rotation_degrees = 0
			smoke.z_index = 0
		Data.Direction.DOWN:
			animationName = "down" + animationName
			smoke.position = smokeMarkers[3].position
			smoke.rotation_degrees = 90
			smoke.z_index = 0
	
	self.sprite.play(animationName)

	if not keyIn: 
		self.sprite.pause()
	
	smoke.visible = keyIn
		
	
	
