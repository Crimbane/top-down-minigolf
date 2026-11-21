extends Node


var uiManager: UIManager
var mapContainer: Node2D
var mapNode: Node = null

var currentHole: int = 0
var currentHolePar: int = 0
var strokes: int = 0

enum Map { TestTwo = -2, TestOne = -1, One, Two }
var MapInfo: Dictionary[Map, MapData] = {
	Map.TestOne: MapData.new({
		MapPath = "res://Stages/Game/test_map.tscn",
		HoleNumber = -1,
		ParNumber = 6
	}),
	Map.TestTwo: MapData.new({
		MapPath = "res://Stages/Game/test_map2.tscn",
		HoleNumber = -2,
		ParNumber = 7
	})
}
var currentMap: Map = Map.One

func _ready() -> void:
	pass

func addStrokes(value: int = 1) -> void:
	strokes += value
	uiManager.updateLabels()


func changeMap(nextMap: Map) -> void:
	if nextMap == currentMap:
		return
	
	var nextMapScene: PackedScene = load(MapInfo[nextMap].MapPath)
	if nextMapScene == null:
		return
	
	if mapNode != null:
		mapNode.queue_free()
		mapNode = null
	
	mapNode = nextMapScene.instantiate()
	mapContainer.add_child(mapNode)
	
	currentMap = nextMap
	currentHole = MapInfo[nextMap].HoleNumber
	currentHolePar = MapInfo[nextMap].ParNumber
	strokes = 0
	
	uiManager.updateLabels()
