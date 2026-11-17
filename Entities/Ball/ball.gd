extends RigidBody2D

@onready var shootingPowerLine: Line2D = $ShootingPowerLine
@onready var texture: AnimatedSprite2D = $Texture
@onready var shaderMaterial: ShaderMaterial = texture.material


const MAX_POWER: float = 500
const MIN_POWER: float = 50
const MIN_LINE_WIDTH: float = 10
const LINE_WIDTH_SCALE: float = 0.05
const IMPULSE_FORCE_SCALE: float = 3
var isAiming: bool = false

var time: float = 0.0

func _ready() -> void:
	input_event.connect(_on_input_event)
	sleeping_state_changed.connect(_on_sleeping_changed)

func _process(_delta: float) -> void:
	if isAiming:
		var power = clamp(Vector2.ZERO.distance_to(get_local_mouse_position()), MIN_POWER, MAX_POWER)
		var direction = Vector2.ZERO.direction_to(get_local_mouse_position())
		
		shootingPowerLine.points = [direction * power, Vector2.ZERO]
		shootingPowerLine.width = clamp(power * LINE_WIDTH_SCALE, MIN_LINE_WIDTH, MAX_POWER * LINE_WIDTH_SCALE)
	
	if not sleeping and shaderMaterial:
		if time < 3600.0:
			time += linear_velocity.length() / MAX_POWER / IMPULSE_FORCE_SCALE * 0.1
		else:
			time = 0.0
		shaderMaterial.set_shader_parameter("time", time)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Left Click"):
		if isAiming:
			handleShooting()
			get_viewport().set_input_as_handled()
	if event.is_action_pressed("Right Click"):
		if isAiming:
			isAiming = false
			shootingPowerLine.visible = false

func _on_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Left Click"):
		if not isAiming and sleeping:
			isAiming = true
			shootingPowerLine.visible = true

func _on_sleeping_changed() -> void:
	if sleeping and shaderMaterial:
		var currentDirection = shaderMaterial.get_shader_parameter("direction")
		var currentTime = shaderMaterial.get_shader_parameter("time")
		var currentOffset = shaderMaterial.get_shader_parameter("offset")
		var newOffset = currentDirection * currentTime + currentOffset
		
		time = 0.0
		shaderMaterial.set_shader_parameter("time", time)
		shaderMaterial.set_shader_parameter("direction", Vector2.ZERO)
		shaderMaterial.set_shader_parameter("offset", newOffset)

func handleShooting() -> void:
	isAiming = false
	shootingPowerLine.visible = false
	
	var power = clamp(Vector2.ZERO.distance_to(get_local_mouse_position()), MIN_POWER, MAX_POWER)
	var direction = Vector2.ZERO.direction_to(get_local_mouse_position())
	
	shaderMaterial.set_shader_parameter("direction", direction)
	apply_central_impulse(-direction * power * IMPULSE_FORCE_SCALE)
	
