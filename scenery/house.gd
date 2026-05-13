extends Node3D


func _ready():
	for node in get_children():
		if node is MeshInstance3D:
			node.visibility_range_end = 15.0
			node.visibility_range_end_margin = 2.0
