extends Node2D


func _ready() -> void:
	GameManager.mapContainer = self
	GameManager.changeMap(GameManager.Map.TestOne)
