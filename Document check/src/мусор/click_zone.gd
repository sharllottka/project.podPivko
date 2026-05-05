extends Control

@export var student_spawner_path: NodePath
@export var document_spawner_path: NodePath
@export var bell_2_path: NodePath

@export var delay_seconds: float = 1.0  # задержка перед появлением документа

func _gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		spawn_with_delay()

func spawn_with_delay() -> void:
	# 1️⃣ Сразу спавним студента
	if student_spawner_path:
		var student_spawner = get_node(student_spawner_path)
		student_spawner.spawn_student()
		
	# 2️⃣ Ждём 1 секунду
	await get_tree().create_timer(delay_seconds).timeout
	
	# 3️⃣ Спавним документ
	if document_spawner_path:
		var document_spawner = get_node(document_spawner_path)
		document_spawner.spawn_document()
