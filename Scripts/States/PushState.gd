class_name PushState

extends State

@onready var manager:StateManager = self.getManager()
@export var body:Player
@onready var backToIdle:Callable = func () -> void : self.manager.changeState.bind("Idle")
@onready var move: MovementState = $"../Move"

@export var isPushed:bool
var animationFinished:bool = false

func _ready() -> void:
	self.manager.view.animation_finished.connect(exitAfterAnimationFinish)

func canEnter() -> bool:
	if (not self.manager.hasFurniture): return false
	
	if (self.manager.furniture.isPushed):
		manager.furniture.exitPush()
		self.body.setControls(true)
		self.manager.changeState("Idle")
		self.getManager().item_detector.visible = true
		return false

	
	return manager.hasFurniture && manager.furniture.canPush


func enter() -> void:
	animationFinished = false
	var dir:String = manager.view.animation.split(" ")[1].to_lower()
	
	#if not (manager.wasPreviousState("push")):
	self.manager.view.play("push " + dir)

func update(_delta:float) -> void:
	if (self.animationFinished):
		if (!manager.furniture.isPushed):
			manager.furniture.enterPush(self.body)
		
		
		self.manager.changeState("Idle")

func exitAfterAnimationFinish() -> void:
	if (self.manager.view.animation == "push " + manager.view.animation.split(" ")[1].to_lower()):
		self.animationFinished = true
#func canExit() -> bool:
	#return false

## The last method called when the state is transitioned out of
func exit() -> void:
	self.body.setControls(true)
	self.getManager().item_detector.visible = false
	# manager.furniture.exitPush()
	pass
