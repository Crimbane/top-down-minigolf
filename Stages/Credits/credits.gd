extends Control

@onready var creditsText: Label = $"Made By"
@onready var audioText: Label = $Audio
@onready var anyKeyText: Label = $MarginContainer/AnyKeyLabel
@onready var beachBall: Sprite2D = $Audio/BeachBall

var creditsFinished: bool = false

func _ready() -> void:
	#SoundManager.playMenuMusic()
	var screenSize = get_viewport_rect().size
	
	var target = creditsText.position.x
	creditsText.position.x = screenSize.x + 400
	
	tweenBeachBall()
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(creditsText, "position:x", target, 6.5)
	await tween.finished
	await get_tree().create_timer(4).timeout
	anyKeyText.visible = true
	creditsFinished = true


func _process(_delta: float) -> void:
	if Input.is_anything_pressed() and creditsFinished:
		get_tree().quit()
		#get_tree().change_scene_to_file(GameManager.MAIN_MENU)

func tweenBeachBall() -> void:
	await get_tree().create_timer(3).timeout
	audioText.visible = true
	var screenSize = get_viewport_rect().size
	
	var target = audioText.position.x
	audioText.position.x = screenSize.x + 128
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)
	tween.tween_property(audioText, "position:x" , target, 15)
	tween.parallel()
	tween.set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(beachBall, "rotation_degrees", 277, 15)
	
