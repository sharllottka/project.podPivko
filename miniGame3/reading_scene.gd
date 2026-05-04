extends Control

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_button_pressed()

func _on_button_pressed(): 
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	get_tree().change_scene_to_file("res://levels/level.tscn")
