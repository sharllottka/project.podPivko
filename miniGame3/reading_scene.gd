extends Control

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_button_pressed()

func _on_button_pressed(): 
	
	queue_free() 
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
