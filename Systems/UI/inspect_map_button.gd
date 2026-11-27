extends Button


func _ready() -> void:
	pressed.connect(GameManager.changeCam)
