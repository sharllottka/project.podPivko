extends Control

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$VBoxContainer/ResumeButton.pressed.connect(_on_resume)
	$VBoxContainer/SaveButton.pressed.connect(_on_save)
	$VBoxContainer/SettingsButton.pressed.connect(_on_settings)
	$VBoxContainer/MainMenuButton.pressed.connect(_on_main_menu)

func _on_resume():
	get_tree().paused = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	queue_free()

func _on_save():
	SaveManager.save_game()
	# визуальный фидбек
	$VBoxContainer/SaveButton.text = "Сохранено успешно"
	await get_tree().create_timer(1.5).timeout
	$VBoxContainer/SaveButton.text = "Сохранить"

func _on_settings():
	var options = load("res://options_menu.tscn").instantiate()
	get_tree().root.add_child(options)

func _on_main_menu():
	get_tree().paused = false
	queue_free()
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
