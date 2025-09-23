class_name ThrowState
extends State

@onready var manager:StateManager = self.getManager()
@onready var backToIdle:Callable = func () -> void : self.manager.currentState.transitioned.emit(self.manager.currentState, "Idle")
@export var view:AnimatedSprite2D = null
var furniture:Furniture

## The first method called when the state is transitioned into
func enter() -> void:
	var dir:String = self.view.animation.split(" ")[1].to_lower()
	
	self.view.play("throw " + dir)
	self.view.animation_finished.connect(backToIdle)

## The last method called when the state is transitioned out of
func exit() -> void:
	if (furniture):
		#furniture.position.y = self.body.position.y - 8
		furniture.collision_layer = 1
		furniture.reparent(self.furniture.get_parent().get_parent())
		furniture.position.x -= 20
	
	if (self.view.animation_finished.is_connected(backToIdle)):
		self.view.animation_finished.disconnect(backToIdle)

## Constantly checks for input from the user and changes state.
func update(_delta:float) -> void:
	pass

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(_delta:float) -> void:
	pass
	
func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.get_parent().is_in_group("Furniture")):
		self.furniture = area.get_parent()


func _on_area_2d_area_exited(area: Area2D) -> void:
	self.furniture = null
