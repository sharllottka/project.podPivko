extends Node3D

func _ready():
	var black_material = StandardMaterial3D.new()
	black_material.albedo_color = Color.BLACK
	
	for mesh in find_children("*", "MeshInstance3D", true):
		for i in mesh.get_surface_override_material_count():
			mesh.set_surface_override_material(i, black_material)
