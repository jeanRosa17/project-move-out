extends Area2D

var player: Player
const east:Vector2 = Vector2(1, 0)
const west:Vector2 = Vector2(-1, 0)
const north:Vector2 = Vector2(0, -1)
const south:Vector2 = Vector2(0, 1)

var stopped:bool = false
var active:bool = false
var lastPosition:Vector2
var sliding:bool = false
var instanceDirection:Vector2 = _get_direction()

func _on_body_entered(body: Node2D) -> void:
	# Sets the player to move in the direction of the shape
	print(_get_direction())
	
	if(body is Player):
		player = body
		if(player.canControl):
			player.setControls(false)
		player.manager.changeState("Move")
		player.manager.direction = Vector2(0, 0)
		player.manager.direction = _get_direction()
		lastPosition = player.position
		sliding = true
		active = true
		stopped = false
		
func _on_body_exited(body: Node2D) -> void:
	#re-endables control of the player when they exit
	if(body is Player):
		player = body
		if(!player.canControl):
			player.setControls(true)
		sliding = false
		active = false

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
	if(active && sliding):
		_check_still(lastPosition)
		if(stopped && !player.canControl):
			sliding = false
			player.setControls(true)
		elif(player.canControl && sliding):
			player.setControls(false)
			player.manager.direction = _get_direction()
		lastPosition = player.position
	elif(active):
		stopped = false
		_process_input()

func _check_still(lastPosition:Vector2) -> void:
	await get_tree().create_timer(0.1).timeout
	if((lastPosition - player.position) == Vector2(0, 0)):
		stopped = true
# pushes the player if they attempt to move against the wind
func _process_input() -> void:
	await get_tree().create_timer(0.1).timeout
	match self.get_meta("Direction"):
		"east":
			if((lastPosition - player.position).x < 5):
				sliding = true
		"west": 
			if((lastPosition - player.position).x > 5):
				sliding = true
		"north":
			if((lastPosition - player.position).y < 5):
				sliding = true
		"south":
			if((lastPosition - player.position).y > 5):
				sliding = true
