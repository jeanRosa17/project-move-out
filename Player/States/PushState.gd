class_name PushState

extends State

@onready var manager:StateManager = self.getManager()
@export var body:Player
@onready var backToIdle:Callable = func () -> void : self.manager.changeState.bind("Idle")

@export var isPushing:bool

func canEnter() -> bool:
	var prefix:String = "push"
	
	print("can enter push")
	
	if (manager.furniture && manager.furniture.canPush):
		return true
	else:
		print("error pushing")
		return false


func enter() -> void: 
	var dir:String = manager.view.animation.split(" ")[1].to_lower()
	
	if not (manager.wasPreviousState("push")):
		manager.view.play("push " + dir)
		
	#lock player rotation/flip
	manager.furniture.enterPush(self.body)
		

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

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(_delta:float) -> void:
	pass
	#self.body.move_and_slide()
