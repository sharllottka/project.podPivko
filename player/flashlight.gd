extends SpotLight3D

func _ready():
	spot_range = 40
	spot_angle = 34.0
	spot_range = 20
	spot_angle_attenuation = 30.0  # чем больше тем мягче край
	light_energy = 2
	visible = true

func _unhandled_input(event: InputEvent):
	if event is InputEventKey and event.pressed and event.keycode == KEY_F:
		visible = !visible
