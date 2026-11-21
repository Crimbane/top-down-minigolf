class_name UIManager
extends Control


@onready var strokesLabel: Label = %StrokesValue
@onready var holeLabel: Label = %HoleValue
@onready var parLabel: Label = %ParValue


func _ready() -> void:
	GameManager.uiManager = self


func updateLabels() -> void:
	strokesLabel.text = str(GameManager.strokes)
	holeLabel.text = str(GameManager.currentHole)
	parLabel.text = str(GameManager.currentHolePar)
