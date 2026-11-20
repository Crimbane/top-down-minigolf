extends Node


var uiManager: UIManager

var currentHole: int = 1
var currentHoleStrokes: int = 0
var currentHolePar: int = 3

func _ready() -> void:
	pass


func addStrokes(value: int = 1) -> void:
	currentHoleStrokes += value
	uiManager.updateLabels()
