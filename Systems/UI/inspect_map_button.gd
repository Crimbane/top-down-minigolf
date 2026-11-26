extends Button



func _ready() -> void:
	pressed.connect(_on_button_press)

func _on_button_press() -> void:
	if GameManager.currentCam == GameManager.ballCam:
		GameManager.mapInspectCam.make_current()
		GameManager.currentCam = GameManager.mapInspectCam
	else:
		GameManager.ballCam.make_current()
		GameManager.currentCam = GameManager.ballCam
