extends RigidBody2D

@onready var shootingPowerLine: Line2D = $ShootingPowerLine

const MAX_POWER: float = 500
const MIN_POWER: float = 50
const MIN_LINE_WIDTH: float = 10
const LINE_WIDTH_SCALE: float = 0.05
var isAiming: bool = false

func _ready() -> void:
	input_event.connect(_on_input_event)

func _process(_delta: float) -> void:
	if isAiming:
		var power = clamp(Vector2.ZERO.distance_to(get_local_mouse_position()), MIN_POWER, MAX_POWER)
		var direction = Vector2.ZERO.direction_to(get_local_mouse_position())
		
		shootingPowerLine.points = [direction * power, Vector2.ZERO]
		shootingPowerLine.width = clamp(power * LINE_WIDTH_SCALE, MIN_LINE_WIDTH, MAX_POWER * LINE_WIDTH_SCALE)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Left Click"):
		if isAiming:
			print("aim end")
			handleShooting()
			get_viewport().set_input_as_handled()
	if event.is_action_pressed("Right Click"):
		if isAiming:
			print("aim cancelled")
			isAiming = false
			shootingPowerLine.visible = false

func _on_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Left Click"):
		if not isAiming:
			print("aim start")
			isAiming = true
			shootingPowerLine.visible = true

func handleShooting() -> void:
	isAiming = false
	shootingPowerLine.visible = false
	
	var power = clamp(Vector2.ZERO.distance_to(get_local_mouse_position()), MIN_POWER, MAX_POWER)
	var direction = Vector2.ZERO.direction_to(get_local_mouse_position())
	
	apply_central_impulse(-direction * power * 3)
	
