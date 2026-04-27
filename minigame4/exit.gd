extends Control



func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/level.tscn")
	
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
