extends Control

@export var student_spawner_path: NodePath
@export var document_spawner_path: NodePath
@export var delay_seconds: float = 1.0

@onready var button = $TextureButton

func _ready():
	button.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	spawn_with_delay()

func spawn_with_delay() -> void:
	# 1️⃣ Спавн студента
	if student_spawner_path:
		var student_spawner = get_node(student_spawner_path)
		student_spawner.spawn_student()

	# 2️⃣ Ждём delay
	await get_tree().create_timer(delay_seconds).timeout

	# 3️⃣ Спавн документа
	if document_spawner_path:
		var document_spawner = get_node(document_spawner_path)
		document_spawner.spawn_document()
