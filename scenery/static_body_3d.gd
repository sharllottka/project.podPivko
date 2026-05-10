extends StaticBody3D

func interact():
	print("=== StaticBody interact вызван ===")
	var node = get_parent()
	while node != null:
		print("Проверяем: ", node.name, " | has interact: ", node.has_method("interact"))
		if node.has_method("interact") and node != self:
			print("Вызываем interact у: ", node.name)
			node.interact()
			return
		node = node.get_parent()
	print("Выключатель не найден!")
