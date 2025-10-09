class_name PushState

extends State

@onready var manager:StateManager = self.getManager()
@export var body:Player
@onready var backToIdle:Callable = func () -> void : self.manager.changeState.bind("Idle")

@export var isPushing:bool

#var offsetPosition:Vector2

func canEnter() -> bool:
	var prefix:String = "push"
	
	print("can enter push")
	
	if (manager.furniture2 && manager.furniture2.canPush):
		#if (!self.isPushing):
			###self.manager.furniture.position = self.body.position
			##self.manager.furniture.position.x += 8
			##manager.furniture2.collision_layer = 2;
			##offsetPosition = Vector2(
				##manager.furniture2.position.x - self.body.position.x,
				##manager.furniture2.position.y - self.body.position.y)
			##self.manager.furniture2.velocity = self.body.velocity
			#print("pushing")
			#self.isPushing = true;
		#else:
			###self.manager.furniture.position = self.body.position
			##self.manager.furniture.position.x += 8
			#print("stop pushing")
			#manager.furniture2.collision_layer = 2;
			#manager.furniture2.reparent(manager.furniture2.get_parent().get_parent())
			#self.isPushing = false;
		return true
	else:
		print("error pushing")
		return false

func enter() -> void: 
	var dir:String = manager.view.animation.split(" ")[1].to_lower()
	
	if not (manager.wasPreviousState("push")):
		manager.view.play("push " + dir)
		
	#lock player rotation/flip
	manager.furniture2.enterPush(self.body)
		

## The last method called when the state is transitioned out of
func exit() -> void:
	#manager.furniture2.exitPush()
	pass
	
## Constantly checks for input from the user and changes state.
func update(_delta:float) -> void:
	if (manager.furniture2):
		#print(self.manager.furniture.position.distance_to(self.body.position))
		if (manager.furniture2.position.distance_to(self.body.position) > 400):
			pass
			#self.exit()

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(_delta:float) -> void:
	pass
	#self.body.move_and_slide()
