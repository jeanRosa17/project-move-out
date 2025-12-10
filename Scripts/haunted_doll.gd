extends Node2D

@onready var van_root: Node2D = get_tree().root.find_child("Garage", true, false) 
@onready var haunted_doll: RigidBody2D = get_parent()
var van_area: Area2D = null
var in_van: bool = false

func _ready() -> void:
	add_to_group("haunted_doll")

	if van_root:
		van_area = van_root.get_node_or_null("Placeholder Van/Area2D")
		if van_area == null:
			push_warning("Could not find Area2D child on van_root. Check the node name/path.")
	else:
		push_warning("van_root is not assigned on HauntedDoll.")
		

func _physics_process(_delta: float) -> void:
	if in_van:
		return
	if van_area == null:
		return
	
	var bodies: Array = van_area.get_overlapping_bodies()
	if haunted_doll in bodies:
		in_van = true
		_on_entered_van()

func _on_entered_van() -> void:
	print("Haunted doll entered the van!")
	get_tree().call_group("PossessedFurniture", "unpossess_and_replace")
	queue_free()
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("debug_kill_doll"):
		queue_free()

func _exit_tree() -> void:
	if Engine.is_editor_hint():
		return
	get_tree().call_group("possessed_furniture", "unpossess_and_replace")
