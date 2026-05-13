extends Control

func _ready():
	PauseManager.is_minigame = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_button_pressed():
	PauseManager.is_minigame = false
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	queue_free()
