# HauntedDoll.gd
extends Node2D

func _exit_tree() -> void:
	if Engine.is_editor_hint():
		return
	get_tree().call_group("possessed_furniture", "stop_moving")
