extends Node3D

var sensitivity = 0.2  

@onready var interact_ray = $Camera3D/RayCast3D
@onready var interact_label = $"../CanvasLayer/InteractLabel"

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	if Global.player_pos != Vector3.ZERO:
		get_parent().global_position = Global.player_pos

func _process(_delta: float) -> void:
	_check_interaction_ui()

func _check_interaction_ui() -> void:
	if interact_ray.is_colliding():
		var target = interact_ray.get_collider()
		if target and target.has_method("open_minigame"):
			interact_label.visible = true
		else:
			interact_label.visible = false
	else:
		interact_label.visible = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		get_parent().rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))

	if event.is_action_pressed("interact"):
		if interact_ray.is_colliding():
			var target = interact_ray.get_collider()
			if target and target.has_method("open_minigame"):
				interact_label.visible = false
				target.open_minigame()
