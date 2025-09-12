class_name MovementComponent

var body:CharacterBody2D
var physics:PlayerPhysics

func _init(_body:CharacterBody2D, _physics:PlayerPhysics) -> void:
	if (_physics == null): Exception.new("Player Physics for MovementComponent cannot be null.")
	if (_body == null): Exception.new("CharacterBody2D for MovementComponent cannot be null.")
	
	self.body = _body
	self.physics = _physics

## Sets the player's velocity to increase or decrease based on the given direction (-1 left, 1 right)
func accelerate(direction:Vector2i, delta:float) -> void:
	if direction != Vector2i.ZERO:
		self.body.velocity.x = move_toward(self.body.velocity.x, direction.x * self.body.physics.maxSpeed, self.body.physics.acceleration * delta) 
		self.body.velocity.y = move_toward(self.body.velocity.y, direction.y * self.body.physics.maxSpeed, self.body.physics.acceleration * delta)

## Decreases the player's velocity. This function should only be called after the player
## stops pressing a direction.
func decelerate(delta:float) -> void:
	if (not self.body.velocity.is_equal_approx(Vector2i.ZERO)):
		var deceleration:float = self.physics.deceleration
		self.body.velocity.x = move_toward(self.body.velocity.x, 0, deceleration * delta)
		self.body.velocity.y = move_toward(self.body.velocity.y, 0, deceleration * delta)
