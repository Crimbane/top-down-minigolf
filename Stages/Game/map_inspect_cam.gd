extends Camera2D


var prevPos: Vector2 = Vector2.ZERO
var moveCam: bool = false
var mapSize: Vector2
var topLeftOfMap: Vector2

func _ready() -> void:
	GameManager.mapInspectCam = self
	
	var tileMap = GameManager.tileMapLayer
	mapSize = tileMap.get_used_rect().size * tileMap.tile_set.tile_size
	topLeftOfMap = tileMap.map_to_local(tileMap.get_used_rect().position) - Vector2(tileMap.tile_set.tile_size / 2)	
	position = topLeftOfMap + (mapSize / 2)

func _unhandled_input(event: InputEvent) -> void:
	if GameManager.currentCam != GameManager.mapInspectCam:
		return
	
	if event.is_action_pressed("Left Click") and not moveCam:
		moveCam = true
		prevPos = event.position
	elif event.is_action_released("Left Click") and moveCam:
		moveCam = false
	
	if event is InputEventMouseMotion and moveCam:
		position = (position + prevPos - event.position).clamp(topLeftOfMap, mapSize)
		prevPos = event.position
