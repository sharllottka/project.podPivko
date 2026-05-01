extends Panel

func _ready():
	$ContinueButton.pressed.connect(_on_continue)

func _on_continue():
	Global.clues_count += 1 
	Global.has_note = true    

	visible = false
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	get_tree().change_scene_to_file("res://levels/level.tscn")
