extends Control

@onready var dialogue_animation = $/root/FinalDialog/dialogue_ui/Canvas/AnimationPlayer
@onready var dialogue_text: RichTextLabel = $/root/FinalDialog/dialogue_ui/Canvas/dialogue_text
@onready var speaker_name: RichTextLabel = $/root/FinalDialog/dialogue_ui/Canvas/speaker_name
@onready var continue_button = $/root/FinalDialog/dialogue_ui/Canvas/continue
@onready var texture_rect: TextureRect = $/root/FinalDialog/TextureRect
@onready var fade_rect: ColorRect = $/root/FinalDialog/dialogue_ui/Canvas/ColorRect

var current_line = -1

var dialogues = [
	"Охранник? Уже почти час ночи.",
	"Мне нужно вам кое-то показать. Это важно.",
	"Хорошо... заходи.",
	"Что это?",
	"Я собирал это пять ночей. Студенты. Их тени. Некоторые из них — не люди.",
	"Это... просто бумага. Здесь ничего нет.",
	"Как нет — я сам писал, я сам видел—",
	"Здесь каракули. И пустые листы.",
	"Этого не может быть. Я видел их. Каждую ночь.",
	"Ты нормально себя чувствуешь? Сколько ты уже не спишь нормально?",
	"...Я не знаю.",
	"Иди домой. Отдохни. Завтра всё будет иначе.",
]

var speaker_names = [
	"Комендант",
	"Охранник",
	"Комендант",
	"Комендант",
	"Охранник",
	"Комендант",
	"Охранник",
	"Комендант",
	"Охранник",
	"Комендант",
	"Охранник",
	"Комендант",
]

var textures = [
	preload("res://finalwin/1.jpeg"),  # комендант у двери
	preload("res://finalwin/1.jpeg"),
	preload("res://finalwin/1.jpeg"),  # комендант впускает
	preload("res://finalwin/2.jpg"),
	preload("res://finalwin/2.jpg"),  # игрок выкладывает бумаги
	preload("res://finalwin/2.jpg"),
	preload("res://finalwin/2.jpg"),
	preload("res://finalwin/2.jpg"),
	preload("res://finalwin/3.jpg"),  # комендант смотрит на него
	preload("res://finalwin/3.jpg"),
	preload("res://finalwin/3.jpg"),
	preload("res://finalwin/3.jpg"),  # игрок уходит
]

func _ready():
	print($/root/FinalDialog/dialogue_ui/Canvas/ColorRect)
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	fade_rect.modulate.a = 0.0
	#continue_button.pressed.connect(_on_continue)
	_on_continue()

func _on_continue():
	current_line += 1
	if current_line < dialogues.size():
		dialogue_text.text = dialogues[current_line]
		speaker_name.text = speaker_names[current_line]
		if current_line < textures.size():
			texture_rect.texture = textures[current_line]
		dialogue_animation.play("RESET")
		dialogue_animation.play("new_animation")
	else:
		_fade_to_end()

func _fade_to_end():
	continue_button.visible = false
	var tween = create_tween()
	tween.tween_property(fade_rect, "modulate:a", 1.0, 2.5)
	await tween.finished
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://main_menu/main_menu.tscn")
