@tool
class_name StorageVan
extends Node2D


@export var direction:Data.Direction = Data.Direction.DOWN
@onready var moving_van: CutsceneVan = $"Moving Van"
@onready var loading_carpet: Sprite2D = $"Loading Carpet"

@onready var up_pos: Marker2D = $"Loading Carpet/Up-Pos"
@onready var left_pos: Marker2D = $"Loading Carpet/Left-Pos"
@onready var right_pos: Marker2D = $"Loading Carpet/Right-Pos"
@onready var down_pos: Marker2D = $"Loading Carpet/Down-Pos"
@onready var carpetMarkers:Array[Marker2D] = [up_pos, left_pos, right_pos, down_pos]


@onready var leave_up_pos: Marker2D = $"Leave Area/Up-Pos"
@onready var leave_left_pos: Marker2D = $"Leave Area/Left-Pos"
@onready var leave_right_pos: Marker2D = $"Leave Area/Right-Pos"
@onready var leave_down_pos: Marker2D = $"Leave Area/Down-Pos"
@onready var leaveMarkers:Array[Marker2D] = [leave_up_pos, leave_left_pos, leave_right_pos, leave_down_pos]

@onready var leave_area: Area2D = $"Leave Area"
@onready var collision_shape_2d: CollisionShape2D = $"Leave Area/CollisionShape2D"

var spawnNewObject: bool = false


func _process(_delta:float) -> void:
	#ONLY IN HUB LEVEL (Object Spawner) broken as of right now
	#var scene_path = get_tree().current_scene.filename
	#if scene_path == "res://Levels/HubScene.tscn" && !spawnNewObject:
		##get item that we provide from previous scene and spawn it
		#print("Spawning object")
		#spawnNewObject = true
	
	self.moving_van.direction = self.direction
	self.collision_shape_2d.shape = self.moving_van.collision_shape_2d.shape
	#self.collision_shape_2d.shape.size = self.moving_van.collision_shape_2d.shape.size * 1.25
	
	
	match (self.direction):
		Data.Direction.UP:
			moving_van.position = Vector2(0, -27)
			#loading_carpet.rotation_degrees = 90
			loading_carpet.position = carpetMarkers[0].position
			#leave_area.position = leaveMarkers[0].position
		Data.Direction.LEFT:
			moving_van.position = Vector2(-27, 0)
			#loading_carpet.rotation_degrees = 0
			loading_carpet.position = carpetMarkers[1].position
			#leave_area.position = leaveMarkers[1].position
		Data.Direction.RIGHT:
			moving_van.position = Vector2(27, 0)
			#loading_carpet.rotation_degrees = 0
			loading_carpet.position = carpetMarkers[2].position
			#leave_area.position = leaveMarkers[2].position
		Data.Direction.DOWN:
			moving_van.position = Vector2(0, 27)
			#loading_carpet.rotation_degrees = 90
			loading_carpet.position = carpetMarkers[3].position
			#leave_area.position = leaveMarkers[3].position
	
	self.leave_area.position = moving_van.position


func _on_end_level() -> void:
	%HUD.setDialogueTo(DialogueTag.new().create("res://Narrative/GenericDialogue.txt", "endLevel"))
	%HUD.checkResults()


## Triggered when the player leaves the Carpet's area2D
func _trigger_tetris(body: Node2D) -> void:
	await(get_tree().create_timer(1).timeout)
	%HUD.runTetris()
