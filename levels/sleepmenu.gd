extends Control

func _ready():
	$YesButton.pressed.connect(_on_yes)
	$NoButton.pressed.connect(_on_no)

func _on_yes():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	Global.player_pos = Vector3.ZERO  # сбрасываем позицию!
	Global.current_night = GameManager.current_day
	get_tree().change_scene_to_file("res://Document check/src/main.tscn")
	queue_free()
	
func _on_no():
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	queue_free()
