extends TextureRect

@export var drag_zone: Control
@export var inspect_zone: Control
@export var closed_texture: Texture2D
@export var open_texture: Texture2D
@export var open_overlay_scene: PackedScene

var dragging = false
var offset = Vector2.ZERO
var current_tween: Tween = null
var normal_scale = Vector2(2, 2)
var inspect_scale = Vector2(5, 5)
var _overlay: Control = null

func _ready() -> void:
	mouse_filter = Control.MOUSE_FILTER_STOP
	pivot_offset = size / 2
	scale = normal_scale
	if closed_texture:
		texture = closed_texture
	if open_overlay_scene:
		_overlay = open_overlay_scene.instantiate()
		add_child(_overlay)
		_overlay.visible = false
		var rule_label = _overlay.get_node_or_null("RuleLabel")
		if rule_label:
			rule_label.text = GameManager.get_current_rule()

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			dragging = true
			offset = get_global_mouse_position() - global_position
			if current_tween:
				current_tween.kill()
		else:
			dragging = false
			_update_scale_after_release()

func _process(_delta: float) -> void:
	if dragging:
		global_position = get_global_mouse_position() - offset
		_update_hover_scale()

func _update_hover_scale() -> void:
	if inspect_zone == null:
		return
	if inspect_zone.get_global_rect().has_point(get_global_mouse_position()):
		_scale_to(inspect_scale)
		if open_texture:
			texture = open_texture
		if _overlay:
			_overlay.visible = true
	else:
		_scale_to(normal_scale)
		if closed_texture:
			texture = closed_texture
		if _overlay:
			_overlay.visible = false

func _update_scale_after_release() -> void:
	var rect = get_global_rect()
	if inspect_zone != null and rect.intersects(inspect_zone.get_global_rect()):
		_scale_to(inspect_scale)
		if open_texture:
			texture = open_texture
		if _overlay:
			_overlay.visible = true
		return
	_scale_to(normal_scale)
	if closed_texture:
		texture = closed_texture
	if _overlay:
		_overlay.visible = false

func _scale_to(target: Vector2) -> void:
	if current_tween:
		current_tween.kill()
	current_tween = create_tween()
	current_tween.tween_property(self, "scale", target, 0.15)
