extends Control



func _on_pressed() -> void:
	get_tree().quit() 
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
