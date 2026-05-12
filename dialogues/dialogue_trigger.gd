extends Node3D

@onready var dialogue_ui = get_tree().current_scene.get_node("dialogue_ui/Canvas")
@onready var dialogue_animation = get_tree().current_scene.get_node("dialogue_ui/Canvas/AnimationPlayer")
@onready var speaker_name: RichTextLabel = get_tree().current_scene.get_node("dialogue_ui/Canvas/speaker_name")
@onready var dialogue_text: RichTextLabel = get_tree().current_scene.get_node("dialogue_ui/Canvas/dialogue_text")
@onready var player: CharacterBody3D = get_tree().current_scene.get_node("player")
@onready var continue_btn = dialogue_ui.get_node("continue")
@onready var answers_container = dialogue_ui.get_node("answers_container")
@onready var btn_a = dialogue_ui.get_node("answers_container/AnswerA")
@onready var btn_b = dialogue_ui.get_node("answers_container/AnswerB")
@onready var btn_c = dialogue_ui.get_node("answers_container/AnswerC")
@onready var btn_d = dialogue_ui.get_node("answers_container/AnswerD")

@export var dialogues: Array[String]
@export var speaker_names: Array[String]
@export var speaker: Node3D
@export var is_shadow_dialogue: bool = false

var current_dialoge = -1
var started = false

# только для режима загадок
var phase = 0
var correct_answers = 0
var current_question = 0

var questions = [
	{
		"text": "Я живу в твоей голове,\nно могу разрушить всё снаружи.\nЧто я?",
		"answers": ["Злость", "Воспоминание", "Голос", "Паранойя"],
		"correct": 3
	},
	{
		"text": "Чем ярче свет —\nтем темнее я становлюсь.\nЧто я?",
		"answers": ["Ночь", "Глаза", "Секрет", "Тень"],
		"correct": 3
	},
	{
		"text": "Я всегда иду вперёд,\nно никогда не возвращаюсь.\nМеня нельзя остановить,\nно меня постоянно теряют.\nКто я?",
		"answers": ["Ветер", "Время", "Свет", "Дорога"],
		"correct": 1
	},
	{
		"text": "Чем больше ты меня берёшь,\nтем больше я становлюсь.\nЧто это?",
		"answers": ["Огонь", "Яма", "Песок", "Воздух"],
		"correct": 1
	}
]

var final_question = {
	"text": "Последний вопрос, охранник...\n\nТы не думал, что всё это —\nтолько у тебя в голове?",
	"answers": [
		"Нет.",
		"Иногда я сомневался.",
		"Не знаю.",
		"Может быть..."
	]
}

func _ready() -> void:
	continue_btn.connect("pressed", Callable(self, "continue_dialogue"))
	answers_container.visible = false

	if is_shadow_dialogue:
		btn_a.pressed.connect(_on_answer.bind(0))
		btn_b.pressed.connect(_on_answer.bind(1))
		btn_c.pressed.connect(_on_answer.bind(2))
		btn_d.pressed.connect(_on_answer.bind(3))

func start_dialogue(body):
	if body == player and !started:
		started = true
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		player.SPEED = 0.0
		Global.mouse_sensitivity = 0.0
		if !dialogue_ui.visible:
			dialogue_ui.visible = true
		speaker.look_at(player.global_transform.origin)
		speaker.rotation_degrees.x = 0
		speaker.rotation_degrees.z = 0
		continue_dialogue()

func end_dialogue():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	player.SPEED = 5.0
	Global.mouse_sensitivity = 0.2  # верни то значение которое у тебя по умолчанию
	dialogue_ui.visible = false

func continue_dialogue():
	if is_shadow_dialogue and phase == 3:
		_finish()
		return

	current_dialoge += 1
	if current_dialoge < dialogues.size():
		dialogue_text.text = dialogues[current_dialoge]
		speaker_name.text = speaker_names[current_dialoge]
		_play_animation()
	else:
		if is_shadow_dialogue:
			phase = 1
			_show_question()
		else:
			end_dialogue()

func _show_question():
	var q = questions[current_question]
	speaker_name.text = "Тень"
	dialogue_text.text = q["text"]

	btn_a.text = "А)  " + q["answers"][0]
	btn_b.text = "Б)  " + q["answers"][1]
	btn_c.text = "В)  " + q["answers"][2]
	btn_d.text = "Г)  " + q["answers"][3]

	continue_btn.visible = false
	answers_container.visible = true
	_play_animation()

func _on_answer(index: int):
	if index == questions[current_question]["correct"]:
		correct_answers += 1

	current_question += 1

	if current_question >= questions.size():
		phase = 2
		_show_final_question()
	else:
		_show_question()

func _show_final_question():
	btn_a.pressed.disconnect(_on_answer)
	btn_b.pressed.disconnect(_on_answer)
	btn_c.pressed.disconnect(_on_answer)
	btn_d.pressed.disconnect(_on_answer)

	btn_a.pressed.connect(_on_final_answer.bind(0))
	btn_b.pressed.connect(_on_final_answer.bind(1))
	btn_c.pressed.connect(_on_final_answer.bind(2))
	btn_d.pressed.connect(_on_final_answer.bind(3))

	speaker_name.text = "Тень"
	dialogue_text.text = final_question["text"]

	btn_a.text = "А)  " + final_question["answers"][0]
	btn_b.text = "Б)  " + final_question["answers"][1]
	btn_c.text = "В)  " + final_question["answers"][2]
	btn_d.text = "Г)  " + final_question["answers"][3]

	answers_container.visible = true
	continue_btn.visible = false
	_play_animation()

func _on_final_answer(_index: int):
	phase = 3
	answers_container.visible = false
	continue_btn.visible = true
	speaker_name.text = "Тень"

	if correct_answers >= 3:
		dialogue_text.text = "...\n\nТы умнее чем я думал.\n\nЗапомни то, что узнал.\nЭто пригодится."
	else:
		dialogue_text.text = "...\nНедостаточно.\nМожет в следующий раз."

	_play_animation()

func _finish():
	if not Global.dialogue_done:
		if correct_answers >= 3:
			Global.clues_count += 1
		Global.dialogue_done = true
	end_dialogue()
	Global.show_thought(Global.sleep_thoughts.get(Global.current_night, "Пора спать."))

func _play_animation():
	dialogue_animation.play("RESET")
	dialogue_animation.play("new_animation")
