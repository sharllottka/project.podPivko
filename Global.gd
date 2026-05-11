extends Node

var player_pos: Vector3 = Vector3.ZERO
var clues_count: int = 0
var last_scene: String = "day"  # "day" или "night"
var pending_thought: String = ""
var thought_label: Label = null

var has_note: bool = false
var note_notification_shown: bool = false

var glitch_done: bool = false
var shield_done: bool = false   
var suitcase_done: bool = false 
var puzzle_done: bool = false
var dialogue_done: bool = false
# переменные для сохранения
var current_night: int = 1  # ночь
var current_day: int = 1    # день

var music_volume: float = 1.0
var sfx_volume: float = 1.0
var mouse_sensitivity: float = 0.2
var is_fullscreen: bool = false
var resolution_index: int = 2  # по умолчанию 1920x1080

var night_thoughts = {
	1: "Что-то скрипит... кажется, со второго этажа.",
	2: "Опять эти звуки. Они доносятся снизу... из подвала.",
	3: "В той записке что-то было про первый этаж. Комната 105.",
	4: "Свет погас. Щиток должен быть в подвале.",
	5: "Снова подвал. Но на этот раз я не один здесь..."
}

func show_thought(text: String, duration: float = 4.0):
	if thought_label:
		thought_label.text = text
		thought_label.visible = true
		await get_tree().create_timer(duration).timeout

		if is_instance_valid(thought_label):
			thought_label.visible = false
