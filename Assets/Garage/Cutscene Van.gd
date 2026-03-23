@tool
class_name CutsceneVan
extends StaticBody2D

@export var hasJohn:bool
@export var keyIn:bool ## Determines if the Car should be playing its animation
@onready var sprite:AnimatedSprite2D = $AnimatedSprite2D
@onready var smoke: Node2D = $Smoke


@onready var up_pos: Marker2D = $"Smoke/Up-Pos"
@onready var left_pos: Marker2D = $"Smoke/Left-Pos"
@onready var right_pos: Marker2D = $"Smoke/Right-Pos"
@onready var down_pos: Marker2D = $"Smoke/Down-Pos"

@onready var smokeMarkers:Array[Marker2D] = [up_pos, left_pos, right_pos, down_pos]

@onready var collision_shape_2d: RotatableCollisionShape2D = $CollisionShape2D


@export var direction:Data.Direction = Data.Direction.DOWN

func _ready():
	pass

func _process(delta: float) -> void:
	var animationName:String = "-no-john" if not hasJohn else ""
	
	match (self.direction):
		Data.Direction.UP:
			animationName = "up"
			smoke.position = smokeMarkers[0].position
			smoke.rotation_degrees = 270
			smoke.z_index = 1
			collision_shape_2d.shape = collision_shape_2d.up
		Data.Direction.LEFT:
			animationName = "left" + animationName
			smoke.position = smokeMarkers[1].position
			smoke.rotation_degrees = 180
			smoke.z_index = 0
			collision_shape_2d.shape = collision_shape_2d.left
		Data.Direction.RIGHT:
			animationName = "right" + animationName
			smoke.position = smokeMarkers[2].position
			smoke.rotation_degrees = 0
			smoke.z_index = 0
			collision_shape_2d.shape = collision_shape_2d.right
		Data.Direction.DOWN:
			animationName = "down" + animationName
			smoke.position = smokeMarkers[3].position
			smoke.rotation_degrees = 90
			smoke.z_index = 0
			collision_shape_2d.shape = collision_shape_2d.down
	
	self.sprite.play(animationName)

	if not keyIn: 
		self.sprite.pause()
	
	smoke.visible = keyIn
		
	
	
