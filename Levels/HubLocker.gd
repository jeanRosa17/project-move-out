extends ItemList
var canOpen = false

var contents: Array[Furniture] = []

var canvas:CanvasLayer

@export var spawn_location:Node2D

@export var y_sort:Node2D

func _process(delta:float) -> void:
		if(Input.is_action_just_pressed("Interact") && canOpen):
			canvas = self.get_parent()
			
			if (!canvas.visible):
				canvas.visible = true
			else:
				canvas.visible = false
			

func _on_area_2d_body_entered(body: Node2D) -> void:
	if (body.name == "Player"):
		print("locker")
		canOpen = true
	elif(body is Furniture):
		add(body as Furniture)


func _on_area_2d_body_exited(body: Node2D) -> void:
	if (body.name == "Player"):
		print("no more locker")
		canOpen = false

func add(f: Furniture) -> void:
	print("add")
	contents.append(f)
	var atlas := AtlasTexture.new()
	atlas.atlas = f.sprite_2d.texture
	atlas.region = f.sprite_2d.region_rect
	self.add_item(f.name, atlas)
	if (f.canPush):
		f.exitPush()
	else:
		f.exitLift()
	f.visible = false
	f.collision_layer = 0
	f.collision_mask = 0


func _on_item_clicked(index: int, at_position: Vector2, mouse_button_index: int) -> void:
	var name = self.get_item_text(index)
	for f in (contents.size()):
		if(contents[f].name == name):
			#y_sort.add_child(contents[f])
			
			
			
			self.remove_item(index)
			
			contents[f].visible = true
			contents[f].global_position = spawn_location.global_position
			contents[f].collision_layer = 2
			contents[f].collision_mask = 7
			contents.remove_at(f)
			break
	
