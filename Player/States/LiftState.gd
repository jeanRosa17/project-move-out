class_name LiftState
extends State

@export var view:AnimatedSprite2D
@export var body:Player
@export var furniture:Furniture

## Furniture needs to be not null and needs to be lifted
func canEnter() -> bool:
	if (furniture && furniture.canLift):
		furniture.position = self.body.position
		#furniture.position.y = self.body.position.y - 8
		furniture.collision_layer = 4;
		furniture.reparent(self.body)
		return true
	else:
		return false

## The first method called when the state is transitioned into
func enter() -> void:
	var dir:String = self.view.animation.split(" ")[1].to_lower()
	
	if not (self.view.animation.contains("lift")):
		self.view.play("lift " + dir)

## The last method called when the state is transitioned out of
func exit() -> void:
	pass

## Constantly checks for input from the user and changes state.
func update(_delta:float) -> void:
	self.body.move_and_slide()

## This method runs every _physics_process() frame of the StateManager.
func physicsUpdate(_delta:float) -> void:
	pass


func _on_area_2d_area_entered(area: Area2D) -> void:
	if (area.get_parent().is_in_group("Furniture")):
		self.furniture = area.get_parent()


func _on_area_2d_area_exited(area: Area2D) -> void:
	self.furniture = null
