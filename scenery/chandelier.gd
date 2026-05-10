extends Node3D

var is_on = false
var player = null

func _ready():
	player = get_tree().get_first_node_in_group("player")
	_toggle_lights()
	_toggle_emission()

func _process(_delta):
	if player and $OmniLight3D:
		var dist = global_position.distance_to(player.global_position)
		if is_on:
			$OmniLight3D.visible = dist < 8.0

func _toggle_lights():
	var lights = find_children("*", "Light3D", true, false)
	for light in lights:
		light.visible = is_on

func _toggle_emission():
	var meshes = find_children("*", "MeshInstance3D", true, false)
	for mesh in meshes:
		var mat = mesh.get_surface_override_material(0)
		if not mat:
			mat = mesh.mesh.surface_get_material(0)
			if mat:
				mat = mat.duplicate()
				mesh.set_surface_override_material(0, mat)
		if mat and mat is StandardMaterial3D:
			mat.emission_enabled = is_on

func turn_on():
	is_on = true
	_toggle_lights()
	_toggle_emission()

func turn_off():
	is_on = false
	_toggle_lights()
	_toggle_emission()

func toggle():
	if is_on:
		turn_off()
	else:
		turn_on()
