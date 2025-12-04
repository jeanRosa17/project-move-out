class_name PushState

extends State

@onready var manager:StateManager = self.getManager()
@export var body:Player
@onready var backToIdle:Callable = func () -> void : self.manager.changeState.bind("Idle")

@export var isPushed:bool

func canEnter() -> bool:
	return manager.furniture && manager.furniture.canPush


func enter() -> void: 
	#var dir:String = manager.view.animation.split(" ")[1].to_lower()
	
	#if not (manager.wasPreviousState("push")):
		#manager.view.play("push " + dir)
		
	#lock player rotation/flip
	if (!manager.furniture.isPushed):
		manager.furniture.enterPush(self.body)
	else:
		manager.furniture.exitPush()
		
#func canExit() -> bool:
	#return false

## The last method called when the state is transitioned out of
func exit() -> void:
	#manager.furniture.exitPush()
	pass
	
## Constantly checks for input from the user and changes state.
func update(_delta:float) -> void:
	if (manager.furniture):
		#print(self.manager.furniture.position.distance_to(self.body.position))
		if (manager.furniture.position.distance_to(self.body.position) > 400):
			pass
			#self.exit()
