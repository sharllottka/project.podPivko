extends Control

@onready var music_slider = $Panel/VBoxContainer/MusicSlider
@onready var sfx_slider = $Panel/VBoxContainer/SFXSlider
@onready var sens_slider = $Panel/VBoxContainer/SensSlider
@onready var fullscreen_toggle = $Panel/VBoxContainer/FullscreenToggle
@onready var resolution_option = $Panel/VBoxContainer/ResolutionOption

var resolutions = [
	Vector2i(1280, 720),
	Vector2i(1600, 900),
	Vector2i(1920, 1080),
	Vector2i(2560, 1440)
]

func _ready():
	# ползунки
	music_slider.min_value = 0
	music_slider.max_value = 1
	music_slider.step = 0.01
	music_slider.value = Global.music_volume

	sfx_slider.min_value = 0
	sfx_slider.max_value = 1
	sfx_slider.step = 0.01
	sfx_slider.value = Global.sfx_volume

	sens_slider.min_value = 0.05
	sens_slider.max_value = 1.0
	sens_slider.step = 0.01
	sens_slider.value = Global.mouse_sensitivity

	# Полный экран
	fullscreen_toggle.button_pressed = Global.is_fullscreen
	_apply_fullscreen(Global.is_fullscreen)

	# Разрешения
	resolution_option.clear()
	resolution_option.add_item("1280 x 720")
	resolution_option.add_item("1600 x 900")
	resolution_option.add_item("1920 x 1080")
	resolution_option.add_item("2560 x 1440")
	resolution_option.selected = Global.resolution_index

	# сигналы
	music_slider.value_changed.connect(_on_music_changed)
	sfx_slider.value_changed.connect(_on_sfx_changed)
	sens_slider.value_changed.connect(_on_sens_changed)
	fullscreen_toggle.toggled.connect(_apply_fullscreen)
	resolution_option.item_selected.connect(_on_resolution_changed)
	$Panel/VBoxContainer/BackButton.pressed.connect(_on_back)

func _on_music_changed(value):
	Global.music_volume = value
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("Music"),
		linear_to_db(value)
	)

func _on_sfx_changed(value):
	Global.sfx_volume = value
	AudioServer.set_bus_volume_db(
		AudioServer.get_bus_index("SFX"),
		linear_to_db(value)
	)

func _on_sens_changed(value):
	Global.mouse_sensitivity = value

func _apply_fullscreen(enabled):
	Global.is_fullscreen = enabled
	if enabled:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)

func _on_resolution_changed(index):
	Global.resolution_index = index
	if not Global.is_fullscreen:
		DisplayServer.window_set_size(resolutions[index])

func _on_back():
	queue_free()
