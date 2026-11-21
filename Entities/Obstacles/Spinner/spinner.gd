extends AnimatableBody2D

## Controls the direction of spin.[br]Clockwise = 1[br]Counterclockwise = -1
@export var spinningDir: int = 1

var spinningSpeed: float = 1.0

func _physics_process(delta: float) -> void:
	if spinningDir == 1 or spinningDir == -1:
		rotation += spinningSpeed * spinningDir * delta
	else:
		push_error("Spinning Direction can only be set to either 1 or -1.")
