extends Control

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE


func _on_button_pressed():
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	queue_free()
