extends Area2D

var player: Player
var east = Vector2(1, 0)
var west = Vector2(-1, 0)
var north = Vector2(0, -1)
var south = Vector2(0, 1)

var sliding:bool = false
var instanceDirection:Vector2 = _get_direction()

func _on_body_entered(body: Node2D) -> void:
	# Sets the player to move in the direction of the shape
	print(_get_direction())
	if(body.name == "Player"):
		player = body
		if(player.canControl):
			player.offControls()
		player.manager.changeState("Move")
		player.manager.direction = Vector2(0, 0)
		player.manager.direction = _get_direction()
		sliding = true
		
func _on_body_exited(body: Node2D) -> void:
	#re-endables control of the player when they exit
	if(body.name == "Player"):
		player = body
		if(!player.canControl):
			player.onControls()
			sliding = false

func _get_direction() -> Vector2:
	# Sets objects which enter the area to move in the direction of the area
	# 1 = east, 2 = west, 3 = north, 4 = south
	match self.get_meta("Direction"):
		"east":
			return east
		"west":
			return west
		"north": 
			return north
		"south":
			return south
	return Vector2(0, 0)
	
func _process(float) -> void:
	if (sliding):
		_process_input()
		if (player.velocity.length() < .2 && !player.canControl):
			player.manager.direction = _get_direction()
			player.onControls()
		elif (player.canControl):
			player.offControls()
			_process_input()

# pushes the player if they attempt to move against the wind
func _process_input() -> void:
	match self.get_meta("Direction"):
		"east":
			if(player.velocity.x < 0):
				player.manager.direction = _get_direction()
				
		"west": 
			if(player.velocity.x > 0):
				player.manager.direction = _get_direction()
		"north":
			if(player.velocity.y > 0):
				player.manager.direction = _get_direction()
		"south":
			if(player.velocity.y < 0):
				player.manager.direction = _get_direction()
