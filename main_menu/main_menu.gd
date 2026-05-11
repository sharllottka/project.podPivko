extends Control

@onready var bg_music = $Sound

func _ready():
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	bg_music.volume_db = -30
	bg_music.finished.connect(bg_music.play)
	bg_music.play()
	$VBoxContainer/Button4.pressed.connect(_on_continue)
	$VBoxContainer/Button.pressed.connect(_on_start)
	$VBoxContainer/Button2.pressed.connect(_on_options)
	$VBoxContainer/Button3.pressed.connect(_on_exit)

func _on_continue():
	if SaveManager.has_save():
		SaveManager.load_game()
		if Global.last_scene == "night":
			get_tree().change_scene_to_file("res://levels/level.tscn")
		else:
			get_tree().change_scene_to_file("res://Document check/src/main.tscn")
	else:
		$VBoxContainer/Button4.text = "Нет сохранений!"
		await get_tree().create_timer(1.5).timeout
		$VBoxContainer/Button4.text = "Продолжить"

func _on_start():
	bg_music.stop()
	$VBoxContainer/Button.text = "Загрузка..."
	$VBoxContainer/Button.disabled = true
	await get_tree().process_frame
	await get_tree().process_frame
	get_tree().change_scene_to_file("res://intro/intro_dialog.tscn")

func _on_options():
	var options = load("res://options_menu.tscn").instantiate()
	get_tree().root.add_child(options)

func _on_exit():
	get_tree().quit()
