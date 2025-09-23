class_name PushState

extends State

@onready var manager:StateManager = self.getManager()
@export var view:AnimatedSprite2D
@export var body:Player
@onready var backToIdle:Callable = func () -> void : self.manager.changeState.bind("Idle")

func canEnter() -> bool:
	if (self.manager.furniture && self.manager.furniture.canPush):
		self.manager.furniture.position = self.body.position
		self.manager.furniture.position.x += 8
		self.manager.furniture.collision_layer = 4;
		self.manager.furniture.reparent(self.body)
		return true
	else:
		return false

func enter() -> void: 
	var dir:String = self.view.animation.split(" ")[1].to_lower()
	
	if not (self.view.animation.contains("push")):
		self.view.play("push " + dir)

## The last method called when the state is transitioned out of
func exit() -> void:
	if (self.manager.furniture):
		#self.manager.furniture.position.y = self.body.position.y - 8
		self.manager.furniture.collision_layer = 1
		self.body.remove_child(self.manager.furniture)
		self.body.get_parent().add_child(self.manager.furniture)
		#self.manager.furniture.get_parent().add_sibling(self.manager.furniture)
		self.manager.furniture.position.x -= 20
	
## Constantly checks for input from the user and changes state.
func update(_delta:float) -> void:
	pass

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(_delta:float) -> void:
	pass
	#pass
	#self.body.move_and_slide()
