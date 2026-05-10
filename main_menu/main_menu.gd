extends Control

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	$VBoxContainer/Button.pressed.connect(_on_start)
	$VBoxContainer/Button2.pressed.connect(_on_options)
	$VBoxContainer/Button3.pressed.connect(_on_exit)

func _on_start():
	$VBoxContainer/Button.text = "LOADING..."
	$VBoxContainer/Button.disabled = true
	await get_tree().process_frame
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://levels/level.tscn")

func _on_options():
	var options = load("res://options_menu.tscn").instantiate()
	get_tree().root.add_child(options)

func _on_exit():
	get_tree().quit()
