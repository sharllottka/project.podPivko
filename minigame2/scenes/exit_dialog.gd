# exit_dialog.gd
extends Panel

func _ready():
	$YesButton.pressed.connect(_on_yes)
	$NoButton.pressed.connect(_on_no)

func _on_no():
	visible = false
	get_tree().paused = false

func _on_yes():
	get_tree().paused = false

	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

	get_tree().change_scene_to_file("res://levels/level.tscn")
