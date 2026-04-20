extends Control

func _on_button_pressed(): 

	queue_free() 
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _on_pressed() -> void:
	pass # Replace with function body.
