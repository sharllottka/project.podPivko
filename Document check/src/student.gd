extends Control

@export var target_position: Vector2
@export var move_duration: float = 0.5
@export var spawn_scale: Vector2 = Vector2(0.5, 0.5)
@export var final_scale: Vector2 = Vector2(1, 1)

func setup(data: StudentData) -> void:
	if data == null:
		return
	var photo_node = get_node_or_null("TextureRect")
	if photo_node and data.photo:
		photo_node.texture = data.photo

func appear() -> void:
	global_position = Vector2(target_position.x - 200, target_position.y)
	scale = spawn_scale
	modulate.a = 0
	var tween = create_tween()
	tween.tween_property(self, "global_position", target_position, move_duration / 500)
	tween.tween_property(self, "scale", final_scale, move_duration)
	tween.tween_property(self, "modulate:a", 1, move_duration)

# Уходит влево — одобрен (проходит)
func leave_approved() -> void:
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "global_position", Vector2(global_position.x - 600, global_position.y), move_duration * 1.5)
	tween.tween_property(self, "modulate:a", 0.0, move_duration)
	tween.chain().tween_callback(queue_free)

# Уходит вправо — отказан (разворачивается и уходит)
func leave_denied() -> void:
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "global_position", Vector2(global_position.x + 200, global_position.y), move_duration * 1.5)
	tween.tween_property(self, "modulate:a", 0.0, move_duration)
	tween.chain().tween_callback(queue_free)

# Обычный уход (документ брошен в зону студента)
func leave() -> void:
	var tween = create_tween().set_parallel(true)
	tween.tween_property(self, "global_position", Vector2(global_position.x - 200, global_position.y), move_duration)
	tween.tween_property(self, "modulate:a", 0.0, move_duration)
	tween.chain().tween_callback(queue_free)
