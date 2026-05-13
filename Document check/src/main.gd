extends Control

@onready var bg_music = $BackgroundSound

func _ready():
	PauseManager.is_3d = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	if bg_music:
		bg_music.volume_db = -15
		bg_music.finished.connect(bg_music.play)
		bg_music.play()
