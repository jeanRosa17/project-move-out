extends Area2D

var player: Player
const east:Vector2 = Vector2(1, 0)
const west:Vector2 = Vector2(-1, 0)
const north:Vector2 = Vector2(0, -1)
const south:Vector2 = Vector2(0, 1)

var lastPosition:Vector2
var sliding:bool = false
var intoWind:bool = false
var shouldProcess:bool = false
var direction:Vector2 = _get_direction()

func _on_body_entered(body: Node2D) -> void:
	# Sets the player to move in the direction of the shape
	if(body is Player):
		player = body
		shouldProcess = true;
		sliding = true
		lastPosition = player.position
		
func _on_body_exited(body: Node2D) -> void:
	#re-endables control of the player when they exit
	if(body is Player):
		player = body
		if(!player.canControl):
			player.setControls(true)
		player.manager.changeState("Move")
		player.manager.direction = direction
		player.setControls(false)
		sliding = false
		shouldProcess = false
		
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

func _process(delta:float) -> void:
	if(shouldProcess):
		# if the player has stopped moving, return controls
		if((lastPosition - player.position == Vector2(0, 0)) && !player.canControl):
			sliding = false
			player.setControls(true)
		if(!sliding):
			# check the player's inputs by velocity
			_process_input()
			# if the player tries to move against the wind, push them back
			if(intoWind):
				print("into wind")
				player.setControls(true)
				player.manager.changeState("Move")
				player.manager.direction = direction
				player.setControls(false)
				sliding = true
				intoWind = false
		if(sliding):
			player.manager.direction = direction
		lastPosition = player.position

func _process_input() -> void:
	match self.get_meta("Direction"):
		"east":
			if((lastPosition - player.position).x < 0):
				intoWind = true
		"west": 
			if((lastPosition - player.position).x > 0):
				intoWind = true
		"north":
			if((lastPosition - player.position).y < 0):
				intoWind = true
		"south":
			if((lastPosition - player.position).y > 0):
				intoWind = true
