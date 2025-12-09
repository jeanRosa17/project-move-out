extends ItemList

@export var needed:Array[Furniture]

var isPressed:bool = false

func _ready() -> void:
	for i in range(needed.size()):
		self.add_item(needed[i].name, needed[i].sprite_2d.texture)
		

func _process(float) -> void:
	if (Input.is_action_just_pressed("Inventory")):
		var layer:CanvasLayer = self.get_parent()
		if (layer.visible):
			layer.visible = false
		else:
			layer.visible = true
	
