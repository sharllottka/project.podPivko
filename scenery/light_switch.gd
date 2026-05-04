extends StaticBody3D

func interact():
	# Код находит все объекты в группе "house_lights" и меняет им видимость
	var all_lights = get_tree().get_nodes_in_group("house_lights")
	for light in all_lights:
		if light is Light3D:
			light.visible = !light.visible
