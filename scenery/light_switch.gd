extends Node3D

@export var chandeliers: Array[NodePath] = []

func interact():
	# на 4 ночь свет недоступен пока не выполнена мини-игра
	if Global.current_night == 4 and not Global.shield_done:
		return
	
	for path in chandeliers:
		var chandelier = get_node_or_null(path)
		if chandelier and chandelier.has_method("toggle"):
			chandelier.toggle()
