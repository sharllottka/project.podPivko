extends Node

var player_pos: Vector3 = Vector3.ZERO
var clues_count: int = 0

var has_note: bool = false
var note_notification_shown: bool = false

var glitch_done: bool = false
var shield_done: bool = false   
var suitcase_done: bool = false 
var puzzle_done: bool = false

# переменные для сохранения
var current_night: int = 1  # ночь
var current_day: int = 1    # день
