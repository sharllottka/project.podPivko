extends CanvasLayer

func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	layer = 100  # у CanvasLayer не z_index а layer!
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	$VBoxContainer/ResumeButton.pressed.connect(_on_resume)
	$VBoxContainer/SaveButton.pressed.connect(_on_save)
	$VBoxContainer/SettingsButton.pressed.connect(_on_settings)
	$VBoxContainer/MainMenuButton.pressed.connect(_on_main_menu)

func _input(event: InputEvent):
	if event is InputEventKey and event.pressed and not event.echo and event.keycode == KEY_ESCAPE:
		# проверяем что настройки не открыты
		for child in get_children():
			if child.name == "options_menu":
				return
		get_viewport().set_input_as_handled()
		_on_resume()

func _on_resume():
	PauseManager.is_paused = false
	get_tree().paused = false
	if PauseManager.is_3d:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	queue_free()

func _on_save():
	var current = get_tree().current_scene.scene_file_path
	if current == "res://Document check/scenes/day_result.tscn":
		$VBoxContainer/SaveButton.text = "Нельзя сохранять здесь!"
		await get_tree().create_timer(1.5).timeout
		$VBoxContainer/SaveButton.text = "Сохранить"
		return
	
	SaveManager.save_game()
	$VBoxContainer/SaveButton.text = "Сохранено успешно"
	await get_tree().create_timer(1.5).timeout
	$VBoxContainer/SaveButton.text = "Сохранить"

func _on_settings():
	$VBoxContainer.visible = false
	var options = load("res://options_menu.tscn").instantiate()
	options.process_mode = Node.PROCESS_MODE_ALWAYS
	add_child(options)  # добавляем внутрь CanvasLayer паузы!
	# когда настройки закроются — показываем кнопки обратно
	options.tree_exited.connect(func(): $VBoxContainer.visible = true)

func _on_main_menu():
	PauseManager.is_paused = false
	get_tree().paused = false
	queue_free()
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
