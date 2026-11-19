extends RigidBody2D


const MAX_POWER: float = 500
const MIN_POWER: float = 50
const MIN_LINE_WIDTH: float = 10
const LINE_WIDTH_SCALE: float = 0.05
const IMPULSE_FORCE_SCALE: float = 3

@onready var animationPlayer: AnimationPlayer = $AnimationPlayer
@onready var arrow: Sprite2D = $Arrow
@onready var shootingPowerLine: Line2D = $ShootingPowerLine
@onready var texture: AnimatedSprite2D = $Texture
@onready var trail: Line2D = $Texture/Trail
@onready var shaderMaterial: ShaderMaterial = texture.material

var skin: String = "default":
	set(newSkin):
		skin = newSkin
		texture.animation = skin

var arrowBounceAnimation: String = "Arrow Bounce"

var isAiming: bool = false
var time: float = 0.0

func _ready() -> void:
	input_event.connect(_on_input_event)
	sleeping_state_changed.connect(_on_sleeping_changed)
	body_entered.connect(_on_collision)
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)

func _process(_delta: float) -> void:
	if isAiming:
		var mousePos = get_local_mouse_position()
		var power = clamp(Vector2.ZERO.distance_to(mousePos), MIN_POWER, MAX_POWER)
		var direction = Vector2.ZERO.direction_to(mousePos)
		
		shootingPowerLine.points = [direction * power, Vector2.ZERO]
		shootingPowerLine.width = clamp(power * LINE_WIDTH_SCALE, MIN_LINE_WIDTH, MAX_POWER * LINE_WIDTH_SCALE)
	
	if not sleeping and shaderMaterial:
		if time < 3600.0:
			time += linear_velocity.length() / MAX_POWER / IMPULSE_FORCE_SCALE * 0.1
		else:
			time = 0.0
		shaderMaterial.set_shader_parameter("time", time)
		
		# Trail
		trail.add_point(global_position)
		if trail.points.size() > 50:
			trail.remove_point(0)
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Left Click"):
		if isAiming:
			handleShooting()
			get_viewport().set_input_as_handled()
	if event.is_action_pressed("Right Click"):
		if isAiming:
			isAiming = false
			shootingPowerLine.visible = false
			arrow.visible = true
			animationPlayer.current_animation = arrowBounceAnimation

func _on_input_event(_viewport: Viewport, event: InputEvent, _shape_idx: int) -> void:
	if event.is_action_pressed("Left Click"):
		if not isAiming and sleeping and shaderMaterial and texture:
			isAiming = true
			shootingPowerLine.visible = true
			texture.scale = Vector2(0.1, 0.1)
			shaderMaterial.set_shader_parameter("outline_size", 0.5)
			shaderMaterial.set_shader_parameter("outline_color", Color(0.0, 0.0, 0.0, 1.0))

func _on_sleeping_changed() -> void:
	if shaderMaterial and animationPlayer and arrow:
		if sleeping:
			arrow.visible = true
			animationPlayer.current_animation = arrowBounceAnimation
			
			var currentDirection = shaderMaterial.get_shader_parameter("direction")
			var currentTime = shaderMaterial.get_shader_parameter("time")
			var currentOffset = shaderMaterial.get_shader_parameter("offset")
			var newOffset = currentDirection * currentTime + currentOffset
			
			time = 0.0
			shaderMaterial.set_shader_parameter("time", time)
			shaderMaterial.set_shader_parameter("direction", Vector2.ZERO)
			shaderMaterial.set_shader_parameter("offset", newOffset)
			
			trail.points = []
		elif not sleeping:
			arrow.visible = false
			animationPlayer.current_animation = ""

func _on_mouse_entered() -> void:
	if sleeping and not isAiming and shaderMaterial and texture:
		arrow.visible = false
		animationPlayer.current_animation = ""
		texture.scale = Vector2(0.125, 0.125)
		shaderMaterial.set_shader_parameter("outline_size", 1.0)
		shaderMaterial.set_shader_parameter("outline_color", Color(1.0, 1.0, 1.0, 1.0))

func _on_mouse_exited() -> void:
	if sleeping and not isAiming and shaderMaterial and texture:
		arrow.visible = true
		animationPlayer.current_animation = arrowBounceAnimation
		texture.scale = Vector2(0.1, 0.1)
		shaderMaterial.set_shader_parameter("outline_size", 0.5)
		shaderMaterial.set_shader_parameter("outline_color", Color(0.0, 0.0, 0.0, 1.0))

func _on_collision(_collisionObject: Node) -> void:
	shaderMaterial.set_shader_parameter("direction", -linear_velocity.normalized())

func handleShooting() -> void:
	isAiming = false
	shootingPowerLine.visible = false
	
	var power = clamp(Vector2.ZERO.distance_to(get_local_mouse_position()), MIN_POWER, MAX_POWER)
	var direction = Vector2.ZERO.direction_to(get_local_mouse_position())
	
	shaderMaterial.set_shader_parameter("direction", direction)
	apply_central_impulse(-direction * power * IMPULSE_FORCE_SCALE)
