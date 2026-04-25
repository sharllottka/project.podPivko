extends Node3D

var sensitivity = 0.2  

@onready var interact_ray = $Camera3D/RayCast3D

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	if Global.player_pos != Vector3.ZERO:
		get_parent().global_position = Global.player_pos

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		get_parent().rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))

	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if interact_ray and interact_ray.is_colliding():
			var target = interact_ray.get_collider()
			if target.has_method("open_minigame"):
				target.open_minigame()
