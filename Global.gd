extends Node

var player_pos: Vector3 = Vector3.ZERO
var clues_count: int = 0

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
