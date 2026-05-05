extends Control

@onready var day_label = $VBoxContainer/DayLabel
@onready var correct_label = $VBoxContainer/CorrectLabel
@onready var incorrect_label = $VBoxContainer/IncorrectLabel
@onready var warning_label = $VBoxContainer/WarningLabel
@onready var next_button = $VBoxContainer/NextButton

func _ready() -> void:
	var stats = GameManager.get_day_stats()
	
	day_label.text = "День %d завершён" % stats["day"]
	correct_label.text = "Правильно: %d" % stats["correct"]
	incorrect_label.text = "Неправильно: %d" % stats["incorrect"]
	
	if stats["got_warning"]:
		warning_label.text = "⚠ Выговор! Всего выговоров: %d/3" % stats["warnings"]
		warning_label.modulate = Color.RED
	else:
		warning_label.text = "✓ День без нареканий"
		warning_label.modulate = Color.GREEN
	
	next_button.pressed.connect(_on_next_pressed)

func _on_next_pressed() -> void:
	GameManager.next_day()
	get_tree().change_scene_to_file("res://levels/level.tscn")  # ← название твоей главной сцены
