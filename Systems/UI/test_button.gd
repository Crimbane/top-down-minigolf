extends Button


@export var map: GameManager.Map


func _ready() -> void:
	pressed.connect(_on_button_press)

func _on_button_press() -> void:
	GameManager.changeMap(map)
