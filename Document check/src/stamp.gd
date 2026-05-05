extends Area2D

@export var stamp_type: String = "approved"  # "approved" или "denied"
@export var stamp_mark_scene: PackedScene

var is_held: bool = false
var original_position: Vector2

func _ready() -> void:
	original_position = global_position

func _process(_delta: float) -> void:
	if is_held:
		global_position = get_global_mouse_position()

	if Input.is_action_just_pressed("mouse_left"):
		if not is_held and _is_mouse_over():
			is_held = true
			return
		if is_held:
			_place_stamp()

	if Input.is_action_just_pressed("mouse_left"):
		if is_held:
			_release_stamp()

func _is_mouse_over() -> bool:
	var shape = $CollisionShape2D.shape
	var rect = Rect2(global_position - shape.size / 2, shape.size)
	return rect.has_point(get_global_mouse_position())

func _place_stamp() -> void:
	var mouse_pos = get_global_mouse_position()
	for doc in get_tree().get_nodes_in_group("documents"):
		if doc.get_global_rect().has_point(mouse_pos):
			# Ставим визуальный отпечаток
			if stamp_mark_scene:
				var mark = stamp_mark_scene.instantiate()
				mark.position = doc.get_local_mouse_position()
				if mark.has_method("set_stamp_type"):
					mark.set_stamp_type(stamp_type)
				doc.add_child(mark)
			# ★ Записываем результат в документ
			doc.stamp_result = stamp_type
			_release_stamp()
			return

func _release_stamp() -> void:
	is_held = false
	var tween = create_tween()
	tween.tween_property(self, "global_position", original_position, 0.2)
