extends Node3D

@export var chandeliers: Array[NodePath] = []

func interact():
	print("light_switch interact вызван, люстр: ", chandeliers.size())
	for path in chandeliers:
		var chandelier = get_node_or_null(path)
		print("Путь: ", path, " | узел: ", chandelier)
		if chandelier and chandelier.has_method("toggle"):
			chandelier.toggle()
