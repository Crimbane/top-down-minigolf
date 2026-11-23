extends Node

@export var startButton: Button
@export var settingsButton: Button
@export var quitButton: Button

func _ready() -> void:
	startButton.pressed.connect(startGame)
	settingsButton.pressed.connect(openSettings)
	quitButton.pressed.connect(quitGame)

func startGame() -> void:
	pass

func openSettings() -> void:
	pass

func quitGame() -> void:
	get_tree().quit()
