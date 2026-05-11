extends TextureRect

var dragging = false
var offset = Vector2.ZERO
@export var drag_zone: Control
@export var inspect_zone: Control
@export var student_zone: Control
@export var closed_texture: Texture
@export var open_texture: Texture
@export var student_spawner: Node = null
@export var stamp_scene: PackedScene
@export var open_overlay_scene: PackedScene

var is_open = true
var normal_scale = Vector2(1, 1)
var inspect_scale = Vector2(2.5, 2.5)
var current_tween: Tween = null
var data: StudentData = null
var _overlay: Control = null

# ★ Результат штампа — записывается штампом, читается при броске на студента
var stamp_result: String = ""

func _ready() -> void:
	add_to_group("documents")
	mouse_filter = Control.MOUSE_FILTER_STOP
	pivot_offset = size / 2
	scale = normal_scale
	if closed_texture:
		texture = closed_texture

func setup(student_data: StudentData) -> void:
	data = student_data
	if data == null:
		return
	if open_overlay_scene and _overlay == null:
		_overlay = open_overlay_scene.instantiate()
		add_child(_overlay)
		_overlay.visible = false
	if _overlay == null:
		return
	var stamp_rect = _overlay.get_node_or_null("Stamp")  # ← название твоего узла
	var namelabel    = _overlay.get_node_or_null("NameLabel")
	var lastnamelabel    = _overlay.get_node_or_null("LastNameLabel")
	var dadnamelabel    = _overlay.get_node_or_null("DadNameLabel")
	var faculty_label = _overlay.get_node_or_null("FacultyLabel")
	var id_label      = _overlay.get_node_or_null("IdLabel")
	var date_label    = _overlay.get_node_or_null("DateLabel")
	var photo_rect    = _overlay.get_node_or_null("Photo")
	if stamp_rect:
		stamp_rect.visible = data.stamp
	if namelabel:
		namelabel.text = data.name
		dadnamelabel.text = data.dadname
		lastnamelabel.text = data.lastname
	if faculty_label:
		faculty_label.text = data.faculty
	if id_label:
		id_label.text = "№ " + data.student_id
	if date_label:
		date_label.text = "Выдан: " + data.issue_date
	if photo_rect:
		if data.id_photo:
			photo_rect.texture = data.id_photo
		elif data.photo:
			photo_rect.texture = data.photo
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			offset = get_global_mouse_position() - global_position
			if current_tween:
				current_tween.kill()
		else:
			dragging = false
			update_scale_after_release()

func _process(_delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position() - offset
		update_hover_scale()

func update_hover_scale() -> void:
	if inspect_zone == null or drag_zone == null:
		return
	if inspect_zone.get_global_rect().has_point(get_global_mouse_position()):
		scale_to(inspect_scale)
		if open_texture:
			texture = open_texture
		if _overlay:
			_overlay.visible = true
	else:
		scale_to(normal_scale)
		if closed_texture:
			texture = closed_texture
		if _overlay:
			_overlay.visible = false

func update_scale_after_release() -> void:
	var doc_rect = get_global_rect()

	if student_zone != null and doc_rect.intersects(student_zone.get_global_rect()):
		# блокируем если штамп не поставлен
		if stamp_result == "":
			scale_to(normal_scale)
			if closed_texture:
				texture = closed_texture
			if _overlay:
				_overlay.visible = false
			return
		
		queue_free()
		if student_spawner != null:
			if data != null:
				GameManager.process_decision(stamp_result, data.is_monster)
			
			if stamp_result == "approved":
				student_spawner.approve_current_student()
			elif stamp_result == "denied":
				student_spawner.deny_current_student()
			else:
				student_spawner.remove_current_student()
		return

	# остальной код без изменений
	if inspect_zone != null and doc_rect.intersects(inspect_zone.get_global_rect()):
		scale_to(inspect_scale)
		if open_texture:
			texture = open_texture
		if _overlay:
			_overlay.visible = true
		return

	scale_to(normal_scale)
	if closed_texture:
		texture = closed_texture
	if _overlay:
		_overlay.visible = false

	if inspect_zone != null and doc_rect.intersects(inspect_zone.get_global_rect()):
		scale_to(inspect_scale)
		if open_texture:
			texture = open_texture
		if _overlay:
			_overlay.visible = true
		return

	scale_to(normal_scale)
	if closed_texture:
		texture = closed_texture
	if _overlay:
		_overlay.visible = false

func scale_to(target: Vector2) -> void:
	if current_tween:
		current_tween.kill()
	
	# запоминаем глобальный центр документа до масштабирования
	var center = global_position + (size * scale) / 2
	
	current_tween = create_tween()
	current_tween.tween_method(
		func(s: Vector2):
			scale = s
			# держим центр на месте
			global_position = center - (size * s) / 2,
		scale,
		target,
		0.15
	)

func is_opened() -> bool:
	return scale == inspect_scale

func place_stamp(_global_mouse_pos: Vector2) -> void:
	if not is_open:
		return
	if stamp_scene == null:
		return
	var stamp = stamp_scene.instantiate()
	add_child(stamp)
	stamp.position = get_local_mouse_position()

func remove_last_stamp() -> void:
	for i in range(get_child_count() - 1, -1, -1):
		var c = get_child(i)
		if c.is_in_group("stamps"):
			c.queue_free()
			break
