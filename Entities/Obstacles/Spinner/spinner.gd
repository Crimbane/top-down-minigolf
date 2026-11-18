extends AnimatableBody2D


var spinningSpeed: float = 1.0

func _physics_process(delta: float) -> void:
	rotation += spinningSpeed * delta
