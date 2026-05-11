extends Control

@onready var dialogue_animation = $Canvas/AnimationPlayer
@onready var dialogue_text: RichTextLabel = $Canvas/dialogue_text
@onready var speaker_name: RichTextLabel = $Canvas/speaker_name
@onready var continue_button = $Canvas/continue

var current_line = -1

var dialogues = [
	"Значит, вы и есть наш новый охранник. Присаживайтесь.",
	 "Работа несложная — проверяете документы у студентов днём.",
	 "Ну и... по ночам иногда бывает всякое. Не пугайтесь.",
	 "Вот ваш пост. Удачи.",
]

var speaker_names = [
	"Комендант",
	"Комендант",
	"Комендант",
	"Комендант",
]

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	_on_continue()

func _on_continue():
	current_line += 1
	if current_line < dialogues.size():
		dialogue_text.text = dialogues[current_line]
		speaker_name.text = speaker_names[current_line]
		dialogue_animation.play("RESET")
		dialogue_animation.play("new_animation")
	else:
		get_tree().change_scene_to_file("res://Document check/src/main.tscn")
