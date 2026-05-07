extends StaticBody3D

func interact():
	var node = get_parent()
	while node != null:
		if node.has_method("interact") and node != self:
			node.interact()
			return
		node = node.get_parent()
	print("Выключатель не найден!")
