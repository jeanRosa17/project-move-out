extends ItemList

@export var needed:Array[Furniture]

var isPressed:bool = false

func _ready() -> void:
	for i in range(needed.size()):
		if needed[i] == null:
			continue
			print("null item")
		var atlas := AtlasTexture.new()
		atlas.atlas = needed[i].sprite_2d.texture
		atlas.region = needed[i].sprite_2d.region_rect
		self.add_item(needed[i].name, atlas)
		

func _process(float) -> void:
	if (Input.is_action_just_pressed("Inventory")):
		var layer:CanvasLayer = self.get_parent()
		if (layer.visible):
			layer.visible = false
		else:
			layer.visible = true
	
