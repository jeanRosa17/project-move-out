extends StateManager
class_name PlayerManager

var furniture:Furniture
var direction:Vector2


func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.get_parent().is_in_group("Furniture")):
		self.furniture = area.get_parent()

func _on_area_2d_area_exited(area: Area2D) -> void:
	self.furniture = null
