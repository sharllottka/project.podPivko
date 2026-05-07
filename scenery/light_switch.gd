extends Node3D

@export var chandeliers: Array[NodePath] = []

func interact():
	for path in chandeliers:
		var chandelier = get_node_or_null(path)
		if chandelier and chandelier.has_method("toggle"):
			chandelier.toggle()
