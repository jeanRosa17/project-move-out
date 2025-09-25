class_name PushState

extends State

@onready var manager:StateManager = self.getManager()
@export var view:AnimatedSprite2D
@export var body:Player
@onready var backToIdle:Callable = func () -> void : self.manager.changeState.bind("Idle")

@export var isPushing:bool

func canEnter() -> bool:
	var prefix:String = "push"
	
	print("can enter push")
	
	if (self.manager.furniture && self.manager.furniture.canPush):
		if (!self.isPushing):
			##self.manager.furniture.position = self.body.position
			self.manager.furniture.position.x += 8
			#self.manager.furniture.collision_layer = 4;
			self.manager.furniture.reparent(self.body)
			self.isPushing = true;
		else:
			##self.manager.furniture.position = self.body.position
			self.manager.furniture.position.x += 8
			self.manager.furniture.collision_layer = 1;
			self.manager.furniture.reparent(self.manager.furniture.get_parent().get_parent())
			self.isPushing = false;
		return true
	else:
		return false

func enter() -> void: 
	var dir:String = self.view.animation.split(" ")[1].to_lower()
	
	if not (self.view.animation.contains("push")):
		self.view.play("push " + dir)

## The last method called when the state is transitioned out of
func exit() -> void:
	pass
	#self.isPushing = false
	#self.manager.furniture.position.x += 8
	#self.manager.furniture.collision_layer = 1;
	#self.manager.furniture.reparent(self.manager.furniture.get_parent().get_parent())
	#self.isPushing = false;
	
## Constantly checks for input from the user and changes state.
func update(_delta:float) -> void:
	if (self.manager.furniture):
		print(self.manager.furniture.position.distance_to(self.body.position))
		if (self.manager.furniture.position.distance_to(self.body.position) > 400):
			pass
			#self.exit()

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(_delta:float) -> void:
	pass
	#pass
	#self.body.move_and_slide()
