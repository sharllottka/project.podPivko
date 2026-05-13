extends Node2D

@onready var bg_music = $BackSound

func _ready():
	PauseManager.is_minigame = true
	process_mode = Node.PROCESS_MODE_ALWAYS
	if bg_music:
		bg_music.finished.connect(_on_music_finished)
		bg_music.volume_db = -30
		bg_music.play()

func _on_music_finished():
	bg_music.play()
