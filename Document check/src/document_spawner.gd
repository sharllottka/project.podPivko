extends Control

@export var document_scene: PackedScene
@export var drag_zone_path: NodePath
@export var inspect_zone_path: NodePath
@export var student_spawner_path: NodePath
@export var spawn_point: Vector2 = Vector2.ZERO
@export var move_duration: float = 0.5
@export var delay_seconds: float = 1.0

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		spawn_document_with_delay()

func spawn_document_with_delay() -> void:
	# 1. Спавним студента
	if student_spawner_path:
		var student_spawner = get_node(student_spawner_path)
		student_spawner.spawn_student()

	# 2. Ждём пока студент подойдёт
	await get_tree().create_timer(delay_seconds).timeout

	# 3. Спавним документ с данными того же студента
	spawn_document()

func spawn_document() -> void:
	if not document_scene:
		return

	var doc = document_scene.instantiate()
	var drag_zone = get_node(drag_zone_path)
	var inspect_zone = get_node(inspect_zone_path)
	var student_spawner = get_node(student_spawner_path)

	get_tree().get_current_scene().add_child(doc)

	# Передаём зоны
	doc.drag_zone = drag_zone
	doc.inspect_zone = inspect_zone
	doc.student_zone = student_spawner
	doc.student_spawner = student_spawner

	# ★ Главное — передаём данные студента в документ
	doc.setup(student_spawner.current_student_data)

	# Анимация въезда
	doc.global_position = global_position + spawn_point
	var target_position = drag_zone.global_position + drag_zone.size / 2 - doc.size / 2
	var tween = create_tween()
	tween.tween_property(doc, "global_position", target_position, move_duration)
