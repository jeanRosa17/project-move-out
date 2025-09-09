## A class containing variables for platformer physics. This class contains values for ground movement,
## jumping, gravity, coyoteTime, jumpSustain.
class_name PlayerPhysics
extends Resource

@export var maxSpeed:float = 200.0 ## The maximum speed velocity.x can be.
@export var acceleration:float = 400.0 ## The speed at which velocity.x increases
@export var deceleration:float = 400.0 ## The speed at which velocity.x decreases
