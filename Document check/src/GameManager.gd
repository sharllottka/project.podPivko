extends Node

# Текущий день (1-5)
var current_day: int = 1

# Счётчики за текущий день
var correct_today: int = 0
var incorrect_today: int = 0
var day_rules: Array[String] = [
	"Сегодня нельзя пропускать студентов с Юрфака",
	"Сегодня нельзя пропускать студентов без печати",
	"Сегодня нельзя пропускать студентов с факультета ИИК",
	"Сегодня нельзя пропускать иностранных студентов",
    "Финальный день — проверяй всё внимательно"
]

func get_current_rule() -> String:
	var idx = current_day - 1
	if idx < day_rules.size():
		return day_rules[idx]
	return ""
# Выговоры за всю игру
var warnings: int = 0

# Студентов обработано сегодня
var students_processed_today: int = 0
const STUDENTS_PER_DAY: int = 5
const MAX_DAYS: int = 5
const MAX_INCORRECT_PER_DAY: int = 2
const MAX_WARNINGS: int = 3

signal day_ended
signal game_over
signal all_days_completed

# В начало файла добавь
var _level_instance: Node = null

func preload_level() -> void:
	if _level_instance != null:
		return  # уже загружен, выходим
	var packed = load("res://levels/level.tscn")
	_level_instance = packed.instantiate()
	_level_instance.visible = false
	_level_instance.process_mode = Node.PROCESS_MODE_DISABLED
	get_tree().root.add_child(_level_instance)

func go_to_level() -> void:
	if _level_instance == null:
		preload_level()
	if get_tree().current_scene != _level_instance:
		get_tree().current_scene.visible = false
	# Скрываем текущую сцену
	get_tree().current_scene.visible = false
	_level_instance.visible = true
	_level_instance.process_mode = Node.PROCESS_MODE_INHERIT  # ← размораживаем
	get_tree().current_scene = _level_instance
	var player_cam = _level_instance.get_node_or_null("player/Camera3D")
	if player_cam and player_cam.has_method("_initialize"):
		player_cam._initialize()

func process_decision(stamp_result: String, is_monster: bool) -> void:
	var correct = (stamp_result == "approved") != is_monster
	if correct:
		correct_today += 1
	else:
		incorrect_today += 1

	students_processed_today += 1

	if students_processed_today >= STUDENTS_PER_DAY:
		_end_day()

func _end_day() -> void:
	if incorrect_today > MAX_INCORRECT_PER_DAY:
		warnings += 1

	if warnings >= MAX_WARNINGS:
		get_tree().change_scene_to_file("res://Document check/scenes/game_over.tscn")
		return

	# Обычный конец дня — показываем статистику
	get_tree().change_scene_to_file("res://Document check/scenes/day_result.tscn")

func next_day() -> void:
	current_day += 1
	correct_today = 0
	incorrect_today = 0
	students_processed_today = 0

func get_day_stats() -> Dictionary:
	return {
		"day": current_day,
		"correct": correct_today,
		"incorrect": incorrect_today,
		"warnings": warnings,
		"got_warning": incorrect_today > MAX_INCORRECT_PER_DAY
	}
