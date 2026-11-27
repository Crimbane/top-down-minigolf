extends Camera2D


var prevPos: Vector2 = Vector2.ZERO
var moveCam: bool = false
var mapSize: Vector2
var topLeftOfMap: Vector2
var bottomRightOfMap: Vector2

func _ready() -> void:
	GameManager.mapInspectCam = self
	
	var tileMap = GameManager.tileMapLayer
	var mapUsedRect = tileMap.get_used_rect()
	
	mapSize = mapUsedRect.size * tileMap.tile_set.tile_size
	topLeftOfMap = tileMap.map_to_local(mapUsedRect.position) - Vector2(tileMap.tile_set.tile_size / 2)
	bottomRightOfMap = topLeftOfMap + mapSize
	
	GameManager.centerOfCurrentMap = topLeftOfMap + (mapSize / 2)


func _unhandled_input(event: InputEvent) -> void:
	if not GameManager.mapInspectCam.is_current():
		return
	
	if event.is_action_pressed("Left Click") and not moveCam:
		moveCam = true
		prevPos = event.position
	elif event.is_action_released("Left Click") and moveCam:
		moveCam = false
	
	if event is InputEventMouseMotion and moveCam:
		position = (position + prevPos - event.position).clamp(topLeftOfMap, bottomRightOfMap)
		prevPos = event.position
